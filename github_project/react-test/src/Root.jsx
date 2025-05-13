// src/Root.jsx
import { Outlet } from 'react-router-dom';

const Root = () => {
  return (
    <div>
      <h1>My App</h1>
      <Outlet /> {/* This renders child routes like /app */}
    </div>
  );
};

export default Root;

