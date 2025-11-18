/**
 * Application configuration
 * Environment variables are prefixed with VITE_ to be accessible in the browser
 */

export const config = {
  // API Configuration
  // ⚠️ DEPRECATED when using reverse proxy approach
  // Recommended: Use reverse proxy and relative paths like fetch('/api/users')
  // This field can be used if you need direct API calls (not recommended for production)
  apiBaseUrl: import.meta.env.VITE_API_URL || '',
  
  // Environment flags
  isDevelopment: import.meta.env.DEV,
  isProduction: import.meta.env.PROD,
  
  // Add your feature flags and non-sensitive config here
  // Example: enableBetaFeatures: import.meta.env.VITE_ENABLE_BETA === 'true',
} as const;

// Type-safe environment variable access
export type Config = typeof config;
