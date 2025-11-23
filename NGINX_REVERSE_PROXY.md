# Nginx Reverse Proxy Configuration

## Overview

This template supports both static-only frontends and frontends with backend APIs.

**For frontends with backend:**
- Nginx reverse proxy routes API/WebSocket requests to backend services
- All configuration via Dockerfile - no manual nginx editing required

**For static-only frontends:**
- Leave `BACKEND_URL` empty - template handles this automatically
- `/api` calls return 502 (expected behavior for static frontend)

**Architecture:** Frontend (nginx) → `/api/*` or `/ws` → Backend Service

## How It Works

1. **Build Time:** `BACKEND_URL` injected into nginx.conf via sed substitution
2. **Runtime:** Nginx proxies matching requests to backend
3. **Frontend Code:** Always uses relative paths (`/api/users`, `/ws`)

## Configuration

**For static-only frontend:**
- No changes needed - `BACKEND_URL` already empty in Dockerfile

**For frontend with backend:**
- Update Dockerfile with backend service URL:

```dockerfile
ARG PORT=1337
ARG BACKEND_URL=<backend_internal_url>
```

**Build Arguments:**
- `PORT` - Nginx listen port (default: 1337)
- `BACKEND_URL` - Backend service internal URL (optional, leave empty for static frontend)

**Alternative approach:** If service variable doesn't work, hardcode URL directly in Dockerfile:
```dockerfile
ARG BACKEND_URL="http://backend-service:{PORT}"
```

## Frontend Code

No configuration needed - use relative paths:

```typescript
// API calls
const response = await fetch('/api/users');

// WebSocket
const ws = new WebSocket(`ws://${window.location.host}/ws`);
```

## Configuration Details

### API Proxy (`/api`)

```nginx
location /api {
    proxy_pass ${BACKEND_URL};
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_connect_timeout 60s;
}
```

- **Path preserved**: `/api/users` → `${BACKEND_URL}/api/users`
- **Timeouts**: 60s for connect/send/read
- **Headers**: Forwards original request info to backend

### WebSocket Proxy (`/ws`)

```nginx
location /ws {
    proxy_pass ${BACKEND_URL}/ws;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
}
```

- **Long-lived**: 1-hour timeouts for persistent connections
- **Full upgrade**: WebSocket-specific headers configured

## Security Benefits

- Backend URL hidden from browser (not in frontend bundle)
- No CORS issues (same origin for frontend and backend)
- Centralized logging and monitoring point
- Rate limiting possible at nginx level

## Ardor Cloud Deployment

**For static-only frontend:**
- No configuration needed - deploy as is

**For frontend with backend:**
1. Get backend service internal URL from backend service data
2. Update Dockerfile with the URL:

```dockerfile
ARG BACKEND_URL=<backend_internal_url>
```

3. Trigger deployment

The internal URL is automatically provided by the platform for each service.

## Troubleshooting

**502 Bad Gateway on /api calls:**
- Verify `BACKEND_URL` is correctly set in Dockerfile
- Check backend service is running and accessible
- Check service logs for nginx errors

**WebSocket connection fails:**
- Verify `/ws` location block in nginx.conf
- Check backend supports WebSocket on `/ws` path
- Ensure proper upgrade headers configured

**Changes not taking effect:**
- Trigger redeployment after Dockerfile changes
- nginx.conf is processed at build time via sed substitution
- Verify Dockerfile ARG values are correct

## Implementation Files

- `Dockerfile` - Multi-stage build with sed substitution
- `nginx.conf` - Template with `${BACKEND_URL}` and `${PORT}` placeholders
- See `ARDOR.md` for complete documentation
