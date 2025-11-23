# React Frontend Template

A modern, production-ready React frontend template built with the latest technologies and best practices.

## 🚀 Features

- **React 18** with TypeScript for type-safe development
- **Vite** for lightning-fast development and building
- **Tailwind CSS** for utility-first styling
- **shadcn/ui** components for beautiful, accessible UI
- **React Router** for client-side routing
- **React Query** for efficient data fetching and caching
- **React Hook Form** with Zod validation
- **Dark/Light mode** support
- **Responsive design** out of the box
- **ESLint & Prettier** for code quality
- **Component composition** patterns
- **Docker support** for containerized deployment
- **Vitest & React Testing Library** for comprehensive testing

## 🛠️ Tech Stack

- **Framework:** React 18 + TypeScript
- **Build Tool:** Vite
- **Styling:** Tailwind CSS
- **UI Components:** shadcn/ui (Radix UI)
- **State Management:** React Query (TanStack Query)
- **Routing:** React Router Dom
- **Form Handling:** React Hook Form + Zod
- **Icons:** Lucide React
- **Development:** ESLint + TypeScript ESLint
- **Testing:** Vitest + React Testing Library

## 🚦 Getting Started

### Prerequisites

- Node.js 18+ 
- npm, yarn, or pnpm

### Installation

1. Clone the repository:
```bash
git clone <your-repo-url>
cd react-frontend-template
```

2. Install dependencies:
```bash
npm install
# or
yarn install
# or
pnpm install
```

3. Start the development server:
```bash
npm run dev
# or
yarn dev
# or
pnpm dev
```

4. Open [http://localhost:1337](http://localhost:1337) in your browser

## 📁 Project Structure

```
src/
├── components/          # Reusable UI components
│   ├── ui/             # shadcn/ui components
│   └── ...             # Custom components
├── hooks/              # Custom React hooks
├── lib/                # Utility functions
├── pages/              # Page components
├── __tests__/          # Test utilities and fixtures
│   ├── fixtures/       # Reusable test data
│   ├── utils/          # Test utilities (custom render, etc.)
│   └── setupTests.ts   # Global test setup
├── App.tsx             # Main App component
├── main.tsx           # React entry point
└── index.css          # Global styles
```

## 📜 Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run build:dev` - Build for development
- `npm run preview` - Preview production build locally
- `npm run lint` - Run ESLint
- `npm test` - Run tests once
- `npm run test:watch` - Run tests in watch mode
- `npm run test:ui` - Run tests with UI
- `npm run test:coverage` - Run tests with coverage report

## 🎨 Customization

### Theme & Colors

The template uses CSS variables for theming. Modify the colors in `src/index.css`:

```css
:root {
  --background: 0 0% 100%;
  --foreground: 222.2 84% 4.9%;
  --primary: 221.2 83.2% 53.3%;
  /* ... other variables */
}
```

### Environment Variables

The template uses environment variables for client-side configuration. Create a `.env` file in the root directory:

```env
# Feature flags and public config only
VITE_ENABLE_DEBUG=false
VITE_APP_VERSION=1.0.0
```

**Important:** 
- All environment variables must be prefixed with `VITE_` to be accessible in the browser
- Never put API keys or secrets in `VITE_*` variables - they're visible in the bundle
- For API calls, use nginx reverse proxy with relative paths (`/api/*`)
- See `ARDOR.md` for complete API integration documentation

### Adding Components

This template includes shadcn/ui components. To add more:

```bash
npx shadcn-ui@latest add button
npx shadcn-ui@latest add card
# etc.
```

## 🚀 Deployment

The template can be deployed to any static hosting service:

### Vercel
```bash
npm run build
vercel --prod
```

### Netlify
```bash
npm run build
# Upload dist/ folder to Netlify
```

### GitHub Pages
Build the project and deploy the `dist/` folder.

### Docker

```bash
# Build the Docker image
docker build -t react-frontend-template .

# Run the container
docker run -p 3000:3000 react-frontend-template
```

The application will be available at http://localhost:3000

For production deployment with backend services, see `ARDOR.md` and `NGINX_REVERSE_PROXY.md`.

## 🧪 Testing

This template includes a comprehensive testing setup with Vitest and React Testing Library.

### Running Tests

```bash
# Run tests once
npm test

# Run tests in watch mode (recommended for development)
npm run test:watch

# Run tests with UI
npm run test:ui

# Generate coverage report
npm run test:coverage
```

### Writing Tests

See [src/__tests__/README.md](src/__tests__/README.md) for detailed testing guidelines, examples, and best practices.

Key features:
- Custom render function with all providers (QueryClient, Router, etc.)
- Reusable fixtures for consistent test data
- Example tests for components and pages
- Proper TypeScript support

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
