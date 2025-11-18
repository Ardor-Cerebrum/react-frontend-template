# Nginx Reverse Proxy Configuration

This branch adds full reverse proxy support for API calls through Nginx in production.

## What's Added

### 1. **Dockerfile Updates**
- Added `BACKEND_URL` build argument
- Automatic substitution of `${BACKEND_URL}` in nginx.conf during build
- Example: `docker build --build-arg BACKEND_URL=http://backend:8000`

### 2. **Nginx Configuration Updates**
- `/api/*` - Proxies all API requests to backend
- `/ws` - WebSocket support with proper headers
- Proper timeout and buffering configuration
- All proxy headers for backend to identify original request

## Usage

### Building with Backend URL

```bash
# With backend URL (enables reverse proxy)
docker build \
  --build-arg PORT=1337 \
  --build-arg BACKEND_URL=http://backend-service:8000 \
  -t my-app .

# Without backend URL (static-only mode)
docker build \
  --build-arg PORT=1337 \
  -t my-app .
```

### Development vs Production

**Development (local):**
- Set `BACKEND_URL` in `.env`
- Vite proxy handles `/api/*` requests
- Points to `http://localhost:8000`

```env
# .env
BACKEND_URL=http://localhost:8000
```

**Production (Docker):**
- Set `BACKEND_URL` as build argument
- Nginx proxy handles `/api/*` requests
- Points to internal service URL

```bash
docker build --build-arg BACKEND_URL=http://backend:8000 -t app .
```

## Frontend Code

No changes needed in frontend code - use relative paths:

```typescript
// Always use relative paths
const response = await fetch('/api/users');

// WebSocket
const ws = new WebSocket('ws://your-domain/ws');
```

## Configuration Details

### API Proxy (`/api`)
- **Target**: `${BACKEND_URL}` (set during build)
- **Path preserved**: `/api/users` → `${BACKEND_URL}/api/users`
- **Timeouts**: 60s for connect/send/read
- **Buffering**: Enabled with 32KB buffers

### WebSocket Proxy (`/ws`)
- **Target**: `${BACKEND_URL}/ws`
- **Upgrade support**: Full WebSocket upgrade headers
- **Long-lived**: 1-hour timeouts for persistent connections

## Important Notes

⚠️ **If `BACKEND_URL` is empty:**
- API requests to `/api/*` will return 502 Bad Gateway
- This is expected if you're running frontend-only
- To disable proxy blocks, comment them out in `nginx.conf` or remove this branch

✅ **Security Benefits:**
- Backend URL hidden from browser
- No CORS issues (same origin)
- Centralized request logging
- Rate limiting possible at Nginx level

## Testing

### Test Static Mode (no backend)
```bash
docker build -t test-app .
docker run -p 8080:1337 test-app
# Visit http://localhost:8080 - should work for static content
# API calls will fail with 502 - this is expected
```

### Test with Backend
```bash
# Build with backend URL
docker build --build-arg BACKEND_URL=http://backend:8000 -t test-app .

# Run (make sure backend is accessible)
docker run -p 8080:1337 test-app

# Test API endpoint
curl http://localhost:8080/api/health
```

## Ardor Cloud Deployment

When deploying to Ardor Cloud with backend service:

```bash
# Backend service will have internal URL like:
# http://service-<id>:8000

docker build \
  --build-arg BACKEND_URL=http://service-66e4ccfd-6a5c-480a-a6ca-daec184b5273:8000 \
  -t ardor-app .
```

## Reverting to Static-Only

If you want to use the template without reverse proxy:

1. Switch back to `main` branch
2. Or comment out `/api` and `/ws` location blocks in `nginx.conf`

## Questions?

See `ARDOR.md` section "API Integration and Reverse Proxy" for detailed architecture explanation.

