import { defineConfig, loadEnv } from "vite";
import react from "@vitejs/plugin-react-swc";
import path from "path";

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => {
  // Load env file based on `mode` in the current working directory.
  // By default, only env variables prefixed with `VITE_` are exposed to your Vite-processed code.
  // We use loadEnv to access non-VITE_ variables in vite.config
  const env = loadEnv(mode, process.cwd(), '');
  
  return {
    server: {
      host: '0.0.0.0',
      port: parseInt(env.PORT || '1337'),
      allowedHosts: [".ardor.cloud"],
      
      // Reverse proxy for API calls during development
      // Set BACKEND_URL in .env (without VITE_ prefix for security)
      // Example: BACKEND_URL=http://localhost:8000
      proxy: env.BACKEND_URL ? {
        '/api': {
          target: env.BACKEND_URL,
          changeOrigin: true,
          secure: false,
          // Keep /api prefix by not using rewrite
          // This ensures consistency between dev and production
        },
        '/ws': {
          target: env.BACKEND_URL.replace('http', 'ws'),
          ws: true,
          changeOrigin: true,
        },
      } : undefined,
    },
    plugins: [react()],
    resolve: {
      alias: {
        "@": path.resolve(__dirname, "./src"),
      },
    },
  };
});
