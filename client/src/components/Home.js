import React from "react";
import {Link } from "react-router-dom";

function Home({ user, Logout }) {

  return (
    <div>
      <nav className="navbar navbar-expand-lg navbar-light bg-light">
        <div className="container-fluid">
          <h2>
            Welcome, <span>{user.firstname}</span>
          </h2>
          <button type="button" aria-expanded="false">
            <Link to="/feedback"><span>Feedback </span> </Link>
          </button>
        </div>

        <button onClick={Logout}> <Link to="">Logout</Link></button>
      </nav>

    </div>
  );
}

export default Home;
