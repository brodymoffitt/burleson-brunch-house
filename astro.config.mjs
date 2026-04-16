import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import vercel from '@astrojs/vercel/serverless';

export default defineConfig({
  output: 'hybrid',
  adapter: vercel(),
  site: 'https://burlesonbrunchhouse.com',
  integrations: [
    tailwind({ applyBaseStyles: false }),
  ],
});
