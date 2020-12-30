import React from 'react';
import { render, screen } from '@testing-library/react';
import App from './App';

test('renders learn react link', () => {
  const { getByText } = render(<App />);
  const linkElement = getByText(/learn react/i);
  expect(linkElement).toBeInTheDocument();
});

test('learn react link contains "learn react"', () => {
  render(<App />)
  expect(screen.getByRole('link')).toHaveTextContent(/learn react/i)
})
