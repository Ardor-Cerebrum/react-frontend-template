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

**Adding components:** Create new component files in `src/components/ui/` using shadcn/ui code examples as reference

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

**Architecture:** Frontend (nginx) → Reverse Proxy → Backend Service

This template supports both static-only frontends and frontends with backend APIs.

**For frontends WITH backend:**
- Use nginx reverse proxy for all API connections (your backend, Firebase, Supabase, third-party APIs)
- Set `BACKEND_URL` in Dockerfile to backend service internal URL

**For static-only frontends:**
- Leave `BACKEND_URL` empty in Dockerfile
- Template handles this automatically - no configuration needed
- `/api` calls will return 502 (expected behavior)

**Benefits of reverse proxy:**
- API keys hidden from browser (security)
- No CORS issues (same origin)
- Single configuration point via `BACKEND_URL`
- Backend URL changes don't require frontend code changes

### How It Works

1. **Build Time:** `BACKEND_URL` from backend service data is injected into nginx.conf
2. **Runtime:** Nginx proxies `/api` requests to backend service
3. **Frontend Code:** Always uses relative paths starting with `/api`

### Configuration

**Dockerfile (production stage):**
```dockerfile
ARG PORT=1337
ARG BACKEND_URL=""  # Leave empty for static-only frontend

# Template automatically handles empty BACKEND_URL
# If empty: /api calls return 502 (expected for static frontend)
# If set: /api proxied to backend service

# Alternative: If service variable doesn't work, hardcode URL directly:
# ARG BACKEND_URL="http://backend-service:{port}"
```

**nginx.conf:**
```nginx
location /api {
    proxy_pass ${BACKEND_URL};
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_connect_timeout 60s;
}

location /ws {
    proxy_pass ${BACKEND_URL}/ws;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
}
```

**Frontend code:**
```typescript
// Always use relative paths - nginx handles routing
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

### Ardor Cloud Deployment

**For static-only frontend:**
- No configuration needed - leave `BACKEND_URL` empty in Dockerfile

**When deploying with a backend service:**

1. Get backend service internal URL from service details (e.g., `data.internal_url`)
2. Update `BACKEND_URL` value in Dockerfile:

```dockerfile
ARG BACKEND_URL=<backend_internal_url>
```

3. Trigger deployment

Example for any backend API:
- Backend exposes endpoints: `/api/users`, `/api/posts`, `/api/auth`
- Frontend calls: `fetch('/api/users')` - nginx proxies to backend
- WebSocket support: `/ws` location also proxied if needed

### Backend Proxy for External APIs

If your backend needs to proxy external services (Firebase, Supabase), handle it in backend code:

```typescript
// backend: Express example
app.get('/api/external/*', async (req, res) => {
  const response = await fetch(`https://api.external.com${req.path}`, {
    headers: { 'Authorization': `Bearer ${process.env.API_SECRET}` }
  });
  res.json(await response.json());
});
```

Secrets stay in backend environment variables only.

### Environment Variables

**Frontend:** Set in Dockerfile (get backend URL from service data):

```dockerfile
ARG PORT=1337
ARG BACKEND_URL=<backend_internal_url>
```

**Backend:** Use environment variables for secrets:

```env
DATABASE_URL=postgresql://user:pass@db:5432/mydb
SUPABASE_SECRET_KEY=your_secret_key
FIREBASE_ADMIN_KEY=your_admin_key
JWT_SECRET=your_jwt_secret
```

Never expose backend secrets to frontend. Use reverse proxy pattern.

## Build and Deployment

Platform automatically builds and deploys via Docker:
- Multi-stage build: Node.js build → Nginx production
- Build args: `PORT` (1337), `BACKEND_URL`
- Nginx configured with SPA routing, caching, reverse proxy
- Update Dockerfile to trigger redeployment

## Development Workflow

### Code Quality
- ESLint configured with TypeScript support
- Type checking integrated with TypeScript
- Linting runs automatically in CI/CD pipeline

### Environment Variables

**For client-side config (feature flags, public settings):**

```env
VITE_ENABLE_DEBUG=false
VITE_APP_VERSION=1.0.0
```

**Rules:**
- `VITE_*` prefix required for browser access
- Never put secrets in `VITE_*` (visible in browser bundle)
- Restart dev server after `.env` changes
- For API calls, always use reverse proxy (relative paths)

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

### Build Issues
- TypeScript errors: Check type definitions and tsconfig files
- Missing dependencies: Verify package.json includes all required packages
- Build cache issues: Clear Vite cache in `node_modules/.vite`

### Styling Issues
- Tailwind not working: Verify content paths in `tailwind.config.ts`
- Theme colors wrong: Check CSS variables in `src/index.css`
- Dark mode not working: Confirm dark mode class on html/body element

### Component Issues
- shadcn/ui updates: Check component version compatibility
- Missing component props: Verify Radix UI peer dependencies installed
- Type errors: Verify TypeScript types match component interfaces

### Routing Issues
- 404 not caught: Ensure custom routes placed above `*` catch-all route
- Navigation broken: Verify BrowserRouter wraps all route components
- Component not loading: Check component exports are correct

### Performance Issues
- Slow rendering: Use React DevTools Profiler to identify bottlenecks
- Large bundle size: Check production build output for optimization opportunities
- Image optimization: Use appropriate formats and sizes
- Long initial load: Implement code splitting for large components

### Environment Variables
- Variables not accessible: Ensure `VITE_` prefix for client-side variables
- Changes not applying: Restart dev server after `.env` file changes
- Never put API keys or secrets in `VITE_*` variables

### API/Network Issues
- CORS errors: Use nginx reverse proxy instead of direct API calls
- 404 on refresh: Check nginx.conf SPA routing configuration
- Connection refused: Verify `BACKEND_URL` is correctly set in Dockerfile
- Request timeouts: Adjust timeout settings in nginx.conf
- Exposed secrets: Always use reverse proxy, never hardcode API URLs in frontend