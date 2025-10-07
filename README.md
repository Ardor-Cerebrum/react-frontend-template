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

4. Open [http://localhost:8080](http://localhost:8080) in your browser.

## 📁 Project Structure

```
src/
├── components/          # Reusable UI components
│   ├── ui/             # shadcn/ui components
│   └── ...             # Custom components
├── hooks/              # Custom React hooks
├── lib/                # Utility functions
├── pages/              # Page components
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

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
