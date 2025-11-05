import { describe, it, expect, vi } from "vitest";
import { render, screen } from "@/__tests__/utils/test-utils";
import NotFound from "./NotFound";

describe("NotFound Page", () => {
  it("renders 404 heading", () => {
    render(<NotFound />);
    expect(screen.getByRole("heading", { name: /404/i })).toBeInTheDocument();
  });

  it("renders error message", () => {
    render(<NotFound />);
    expect(screen.getByText(/Oops! Page not found/i)).toBeInTheDocument();
  });

  it("renders link to home page", () => {
    render(<NotFound />);
    const homeLink = screen.getByRole("link", { name: /Return to Home/i });
    expect(homeLink).toBeInTheDocument();
    expect(homeLink).toHaveAttribute("href", "/");
  });

  it("logs error to console when rendered", () => {
    const consoleSpy = vi.spyOn(console, "error").mockImplementation(() => {});
    render(<NotFound />);
    expect(consoleSpy).toHaveBeenCalled();
    consoleSpy.mockRestore();
  });
});

