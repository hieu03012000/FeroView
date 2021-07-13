import React from "react";
import { Link } from "react-router-dom";

export default function MenuSidebar() {
  return (
    <aside className="menu-sidebar d-none d-lg-block">
      <div className="logo">
        <Link to="/">
          <h3>Fero Admin</h3>
        </Link>
      </div>
      <div className="menu-sidebar__content js-scrollbar1">
        <nav className="navbar-sidebar">
          <ul className="list-unstyled navbar__list">  
            <li>
              <Link to="/auth">
                <i className="fas fa-tachometer-alt"></i>Dashboard
              </Link>
            </li>
          </ul>
        </nav>
      </div>
    </aside>
  );
}