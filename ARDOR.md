# Ardor React Frontend Template Documentation

## Introduction

Production-ready React application template with TypeScript, Vite, Tailwind CSS, and shadcn/ui. Designed for AI agents and developers building scalable web applications.

## Project Overview

**Features:**
- Strict TypeScript configuration
- Vite build optimization
- shadcn/ui components (Radix UI)
- Tailwind CSS mobile-first design
- Hot reload, ESLint, comprehensive tooling
- Modular architecture
- Frontend-only or full-stack deployment

### API Integration

**Rule:** Use reverse proxy for all API connections (own backend, Firebase, Supabase, third-party APIs).

**Reverse proxy benefits:**
- Hide API keys from browser
- Eliminate CORS issues (same origin)
- Enable security and rate limiting
- Centralize logging

Configuration details: [API Integration and Reverse Proxy](#api-integration-and-reverse-proxy)

## Tech Stack

### Core Technologies
- **React 18**: Latest React with concurrent features and hooks
- **TypeScript 5.8+**: Strict type checking and modern JavaScript features
- **Vite 5.4+**: Fast build tool with native ES modules support

### Styling & UI
- **Tailwind CSS 3.4+**: Utility-first CSS framework
- **shadcn/ui**: High-quality, accessible component library
- **Radix UI**: Unstyled, accessible UI primitives
- **Lucide React**: Modern icon library

### State Management & Data
- **TanStack Query (React Query)**: Powerful data fetching and caching
- **React Hook Form**: Performant forms with easy validation
- **Zod**: TypeScript-first schema validation

### Development Tools
- **ESLint**: Code linting with TypeScript support
- **PostCSS**: CSS processing with Autoprefixer
- **TypeScript ESLint**: TypeScript-specific linting rules

### Additional Libraries
- **React Router DOM**: Client-side routing
- **next-themes**: Theme switching (light/dark mode)
- **Sonner**: Toast notifications
- **date-fns**: Modern date utility library
- **class-variance-authority**: Component variant management
- **tailwind-merge**: Intelligent class merging

## Project Structure

```
/
├── src/
│   ├── components/
│   │   ├── ui/           # shadcn/ui components
│   │   └── ...           # Custom components
│   ├── hooks/            # Custom React hooks
│   ├── lib/              # Utilities and configuration
│   ├── pages/            # Route components
│   ├── App.tsx           # Main application component
│   ├── main.tsx          # React entry point
│   └── index.css         # Global styles and CSS variables
├── public/               # Static assets
├── Dockerfile            # Containerization
├── nginx.conf            # Production server config
├── package.json          # Dependencies and scripts
├── vite.config.ts        # Vite configuration
├── tsconfig*.json        # TypeScript configurations
├── tailwind.config.ts    # Tailwind CSS configuration
├── eslint.config.js      # ESLint configuration
├── components.json       # shadcn/ui configuration
└── .env.example          # Environment variables template
```

## Configuration Files

### Vite Configuration (`vite.config.ts`)
- Path alias: `@/` → `./src/`
- Server: Host `0.0.0.0`, port from `PORT` (default: 1337)
- `allowedHosts: [".ardor.cloud"]` - prevents DNS rebinding attacks (dev server security, not API-related)
- Proxy: Auto-configures when `BACKEND_URL` set (dev only)
- React plugin: SWC compilation
- Build: Tree shaking, minification

### TypeScript Configuration
- `tsconfig.json` - Project references, path mapping
- `tsconfig.app.json` - React application settings
- `tsconfig.node.json` - Build tools configuration
- Strict mode disabled (enable for production recommended)

### Tailwind CSS Configuration (`tailwind.config.ts`)
- Dark mode: Class-based switching
- Content: Scans `src/**/*.{ts,tsx}`
- Colors: CSS variables for theming
- Animations: Custom keyframes

### ESLint Configuration (`eslint.config.js`)
- Rules: React hooks, refresh plugins
- Ignores: `dist/`
- TypeScript support with recommended rules

### shadcn/ui Configuration (`components.json`)
- Default theme, TSX enabled
- Pre-configured aliases: components, utils, hooks

## Source Code Organization

### `src/main.tsx`
React 18 entry point. Uses `createRoot`, imports global CSS, renders App.

### `src/App.tsx`
- Providers: QueryClient, Tooltip
- Toasters: shadcn/ui, Sonner
- Router: BrowserRouter
- Routes: Index, 404

### `src/pages/`
- `Index.tsx` - Home page
- `NotFound.tsx` - 404 with logging
- Convention: Add routes above `*` catch-all

### `src/components/`
- `ui/` - shadcn/ui components (do not modify)
- Custom components in subdirectories
- Naming: PascalCase

### `src/hooks/`
- `use-mobile.tsx` - Breakpoint detection (< 768px)
- `use-toast.ts` - Toast notifications
- Custom hooks location

### `src/lib/`
- `utils.ts` - `cn()` for class merging
- `config.ts` - Client config (feature flags, environment)
  - Use for: feature flags, public settings
  - Never: API keys, secrets, backend URLs
  - `apiBaseUrl` deprecated (use relative paths with reverse proxy)

## Styling and Theming

### `src/index.css`
- Colors: HSL values
- Themes: Light and dark mode
- Custom properties: gradients, shadows, transitions
- Global typography and resets

### Tailwind
- Utility classes in JSX
- `@layer components` for reusable styles
- Responsive: `sm:`, `md:`, `lg:` prefixes

### Theme Switching
- `next-themes` for persistence
- CSS variables update on `class="dark"`
- Auto component adaptation

## Components

### shadcn/ui (Pre-installed)
Form controls, Layout, Navigation, Feedback, Data display

Add components: `npx shadcn-ui@latest add [component-name]`

### Patterns
- Composition with `children`, render props
- Variants via `class-variance-authority`
- Forward refs for form controls
- Strict TypeScript typing

## Hooks and Utilities

### Hooks
- `useIsMobile` - Boolean for < 768px
- `useToast` - Notifications

### Utils
- `cn()` - Tailwind class merging
- `config` - Feature flags, environment (no secrets)

**Config usage:**
```typescript
// Feature flags
if (config.isDevelopment) {
  console.log('Debug mode enabled');
}

// API calls - use relative paths with reverse proxy
const response = await fetch('/api/users');
```

## Routing

### Structure
- All routes in `App.tsx`
- `/` → `Index` component
- `*` → `NotFound` (404)

### Adding Routes
1. Create component in `src/pages/`
2. Import in `App.tsx`
3. Add `<Route path="/new" element={<New />} />` above `*` catch-all

### Navigation
- `Link` - Internal links
- `useNavigate` - Programmatic
- `useLocation` - Current route

## API Integration and Reverse Proxy

Use reverse proxy for all API connections (own backend, Firebase, Supabase, third-party APIs).

**Benefits:**
- Hide API keys from browser
- No CORS (same origin)
- Centralized logging, rate limiting
- Provider switching without frontend changes

### Development

`.env`:
```env
BACKEND_URL=http://localhost:8000
```

`vite.config.ts` (pre-configured):
```typescript
const env = loadEnv(mode, process.cwd(), '');

proxy: env.BACKEND_URL ? {
  '/api': { target: env.BACKEND_URL, changeOrigin: true },
  '/ws': { target: env.BACKEND_URL.replace('http', 'ws'), ws: true },
} : undefined
```

**Notes:**
- `BACKEND_URL` (no `VITE_` prefix) - vite.config only, not exposed to browser
- `/api` prefix preserved in dev and prod
- Never put secrets in `VITE_*` variables (visible in browser)

**Example Express proxy for external APIs:**
```typescript
// backend/server.ts
import express from 'express';
const app = express();

app.get('/api/*', async (req, res) => {
  const url = `https://api.supabase.co${req.path.replace('/api', '')}`;
  const response = await fetch(url, {
    headers: {
      'Authorization': `Bearer ${process.env.SUPABASE_SECRET_KEY}`,
      'apikey': process.env.SUPABASE_ANON_KEY,
    }
  });
  res.json(await response.json());
});
app.listen(8000);
```

### Production

Dockerfile:
```dockerfile
FROM nginx:alpine
ARG PORT=1337
ARG BACKEND_URL=http://backend-service:8000

COPY nginx.conf /etc/nginx/nginx.conf
RUN sed -i "s/\${PORT}/${PORT}/g" /etc/nginx/nginx.conf && \
    sed -i "s|\${BACKEND_URL}|${BACKEND_URL}|g" /etc/nginx/nginx.conf

COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE ${PORT}
ENV PORT=${PORT} BACKEND_URL=${BACKEND_URL}
CMD ["nginx", "-g", "daemon off;"]
```

nginx.conf:
```nginx
server {
    listen ${PORT};
    root /usr/share/nginx/html;

    location /api {
        proxy_pass ${BACKEND_URL};
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }

    location /ws {
        proxy_pass ${BACKEND_URL}/ws;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

Application code:
```typescript
// src/hooks/useUser.ts
export const useUser = (id: string) => {
  return useQuery({
    queryKey: ["user", id],
    queryFn: async () => {
      const res = await fetch(`/api/users/${id}`);
      if (!res.ok) throw new Error('Failed to fetch user');
      return res.json();
    },
  });
};
```

### Trade-offs

**Advantages:**
- Security: Backend URL hidden
- No CORS (same origin)
- Single entry point
- Load balancing, SSL termination, rate limiting

**Disadvantages:**
- Additional network hop (minimal latency)
- More complex configuration
- Nginx as single point of failure

Note: Static sites without API calls can skip reverse proxy.

### Environment Variables

Frontend `.env`:
```env
BACKEND_URL=http://localhost:8000
```

Backend `.env`:
```env
SUPABASE_SECRET_KEY=your_key
FIREBASE_ADMIN_KEY=your_key
DATABASE_URL=postgresql://...
```

Docker build:
```bash
docker build \
  --build-arg BACKEND_URL=http://backend:8000 \
  -t app .
```

## Build and Deployment

Commands:
```bash
npm run dev      # Dev server (PORT env, default: 1337)
npm run build    # Production build
npm run preview  # Preview build
```

### Docker
- Multi-stage build with Nginx
- Build args: `PORT` (1337), `BACKEND_URL`
- SPA routing, caching, reverse proxy configured

### Static Hosting
- Vercel/Netlify/GitHub Pages: Deploy `dist/`
- For API calls: Separate backend or platform edge functions

## Development Workflow

### Code Quality
```bash
npm run lint     # ESLint
```
Type checking: Integrated with TypeScript

### Environment Variables

`.env`:
```env
PORT=1337
BACKEND_URL=http://localhost:8000  # vite.config only
VITE_ENABLE_DEBUG=false            # Browser-accessible
```

**Rules:**
- `VITE_*` - Exposed to browser (feature flags, public settings only)
- No `VITE_` - Node.js only (vite.config.ts)
- Never put secrets in `VITE_*` (visible in browser)
- Store secrets on backend only
- Restart dev server after changes

## Best Practices

### Components
- Start with shadcn/ui
- Strict TypeScript prop interfaces
- Radix primitives for accessibility
- Mobile-first, memoize expensive ops

### State
- Local: `useState`
- Server: React Query
- Global: Context/Zustand
- Forms: React Hook Form + Zod

### API
- Always use reverse proxy
- React Query for fetching
- Relative paths `/api/*`
- Error boundaries, toast notifications
- Loading states, caching

### Styling
- Tailwind utility classes
- CSS variables for themes
- CVA for variants
- Dark mode via CSS variables

### File Organization
- Feature folders, barrel exports
- Colocate types with components
- Constants in `lib/`

### Performance
- Code splitting, lazy loading
- Monitor bundle size
- Optimize images
- Memoization

## Code Examples

### New Page
```tsx
// src/pages/Dashboard.tsx
const Dashboard = () => (
  <div className="container mx-auto py-8">
    <h1 className="text-3xl font-bold">Dashboard</h1>
  </div>
);
export default Dashboard;

// src/App.tsx
<Route path="/dashboard" element={<Dashboard />} />
```

### Custom Component
```tsx
// src/components/CustomButton.tsx
import { Button, type ButtonProps } from "@/components/ui/button";
import { cn } from "@/lib/utils";

interface CustomButtonProps extends ButtonProps {
  variant?: "primary" | "secondary";
}

export const CustomButton = ({ className, variant = "primary", ...props }: CustomButtonProps) => (
  <Button
    className={cn(
      variant === "primary" && "bg-primary hover:bg-primary/90",
      variant === "secondary" && "bg-secondary hover:bg-secondary/90",
      className
    )}
    {...props}
  />
);
```

### React Query
```tsx
// src/hooks/useUser.ts
export const useUser = (id: string) => {
  return useQuery({
    queryKey: ["user", id],
    queryFn: async () => {
      const res = await fetch(`/api/users/${id}`);
      if (!res.ok) throw new Error('Failed');
      return res.json();
    },
  });
};
```

### Form Validation
```tsx
// src/components/LoginForm.tsx
const schema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
});

export const LoginForm = () => {
  const form = useForm({ resolver: zodResolver(schema) });
  return (
    <form onSubmit={form.handleSubmit(console.log)}>
      <Input {...form.register("email")} />
      <Input {...form.register("password")} type="password" />
      <Button type="submit">Login</Button>
    </form>
  );
};
```

## Troubleshooting

### Build
- TypeScript errors: `npx tsc --noEmit`
- Dependencies: `npm install`
- Clear cache: `rm -rf node_modules/.vite`

### Styling
- Verify Tailwind in content paths
- Check CSS variables
- Confirm dark mode class on html/body

### Components
- shadcn/ui: `npx shadcn-ui@latest diff`
- Check Radix UI peer dependencies
- Verify TypeScript types

### Routing
- Routes above `*` catch-all
- BrowserRouter wrapping
- Component exports

### Performance
- React DevTools Profiler
- Bundle size: `npm run build`
- Optimize images
- Code splitting

### Environment
- `VITE_` prefix for client variables
- `.env` in project root
- Restart dev server after changes

### API/Network
- CORS: Use reverse proxy
- 404: Check `vite.config.ts` (dev) and `nginx.conf` (prod)
- Connection refused: Verify backend URL
- Timeouts: Adjust nginx.conf settings
- Exposed keys: Never use `VITE_API_URL`, use reverse proxy