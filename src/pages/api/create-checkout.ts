export const prerender = false;

import type { APIRoute } from 'astro';

interface CartItem {
  name: string;
  price: number;
  qty: number;
}

const cloverBase = () =>
  import.meta.env.CLOVER_ENV === 'sandbox'
    ? 'https://sandbox.dev.clover.com'
    : 'https://api.clover.com';

export const POST: APIRoute = async ({ request }) => {
  const token      = import.meta.env.CLOVER_API_TOKEN as string | undefined;
  const merchantId = import.meta.env.CLOVER_MERCHANT_ID as string | undefined;

  if (!token || !merchantId) {
    return new Response(JSON.stringify({ error: 'Clover is not configured.' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  let body: { items: CartItem[]; name: string; phone: string; notes: string; origin: string };

  try {
    body = await request.json();
  } catch {
    return new Response(JSON.stringify({ error: 'Invalid request body.' }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  const { items, name, phone, notes, origin } = body;

  if (!items?.length) {
    return new Response(JSON.stringify({ error: 'Cart is empty.' }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  // Encode full order data so the success page can push it to the Clover POS
  const encoded = Buffer.from(JSON.stringify({ name, phone, notes, items })).toString('base64url');

  // Build Clover line items — prices in cents, one entry per unit of qty
  const lineItems = items.flatMap(item =>
    Array.from({ length: item.qty }, () => ({
      name: item.name,
      unitQty: 1,
      price: Math.round(item.price * 100),
    }))
  );

  const res = await fetch(`${cloverBase()}/invoicingcheckoutservice/v1/checkouts`, {
    method: 'POST',
    headers: {
      'Authorization':       `Bearer ${token}`,
      'X-Clover-Merchant-Id': merchantId,
      'Content-Type':        'application/json',
    },
    body: JSON.stringify({
      customer: { firstName: name, phoneNumber: phone },
      shoppingCart: { lineItems },
      redirectUrls: {
        success: `${origin}/order/success?o=${encoded}&name=${encodeURIComponent(name)}`,
        failure: `${origin}/order/cancel`,
      },
    }),
  });

  if (!res.ok) {
    const err = await res.text();
    console.error('Clover checkout error:', err);
    return new Response(JSON.stringify({ error: 'Could not create checkout. Please call us.' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  const data = await res.json();

  return new Response(JSON.stringify({ url: data.href }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
};
