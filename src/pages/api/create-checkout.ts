export const prerender = false;

import type { APIRoute } from 'astro';
import Stripe from 'stripe';

interface CartItem {
  name: string;
  price: number;
  qty: number;
}

export const POST: APIRoute = async ({ request }) => {
  const key = import.meta.env.STRIPE_SECRET_KEY as string | undefined;

  if (!key) {
    return new Response(JSON.stringify({ error: 'Stripe is not configured yet.' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  const stripe = new Stripe(key);

  let body: {
    items: CartItem[];
    name: string;
    phone: string;
    pickup_time: string;
    notes: string;
    origin: string;
  };

  try {
    body = await request.json();
  } catch {
    return new Response(JSON.stringify({ error: 'Invalid request body.' }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  const { items, name, phone, pickup_time, notes, origin } = body;

  if (!items?.length) {
    return new Response(JSON.stringify({ error: 'Cart is empty.' }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  const session = await stripe.checkout.sessions.create({
    payment_method_types: ['card'],
    line_items: items.map(item => ({
      price_data: {
        currency: 'usd',
        product_data: { name: item.name },
        unit_amount: Math.round(item.price * 100),
      },
      quantity: item.qty,
    })),
    mode: 'payment',
    metadata: {
      customer_name: name,
      phone,
      pickup_time,
      notes: notes ?? '',
    },
    // Show order summary on Stripe's checkout page
    custom_text: {
      submit: {
        message: `Pickup at Burleson Brunch House · ${pickup_time} · (682) 730-1391`,
      },
    },
    success_url: `${origin}/order/success?name=${encodeURIComponent(name)}&pickup=${encodeURIComponent(pickup_time)}`,
    cancel_url: `${origin}/order/cancel`,
  });

  return new Response(JSON.stringify({ url: session.url }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
};
