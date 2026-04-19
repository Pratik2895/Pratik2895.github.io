import { defineCollection, z } from 'astro:content';

const projects = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    tagline: z.string(),
    summary: z.string(),
    role: z.string(),
    period: z.string().optional(),
    stack: z.array(z.string()),
    tags: z.array(z.string()),
    repo: z.string().url(),
    demo: z.string().url().optional(),
    featured: z.boolean().default(false),
    order: z.number().default(99),
    arch: z.enum(['medallion', 'rag', 'azure', 'analytics']).default('medallion'),
    accent: z.enum(['cyan', 'violet', 'amber', 'emerald']).default('cyan'),
    metrics: z.array(z.object({
      label: z.string(),
      value: z.string(),
    })).optional(),
  }),
});

export const collections = { projects };
