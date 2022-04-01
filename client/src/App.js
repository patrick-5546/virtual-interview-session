import React, { useState } from 'react';
import LoginForm from './components/LoginForm';

function App() {
  const adminUser = {
    email: "cpen@admin.com",
    password: "cpen123"
  }

  const [user, setUser] = useState({firstname: "", lastname: "", email: ""});
  const [error, setError] = useState("");

  const Login = details => {
    console.log(details);

    if(details.email == adminUser.email && details.password == adminUser.password) {
      console.log("Logged in");
      setUser({
        firstname: details.firstname,
        lastname: details.lastname,
        email: details.email
      });
    } else {
      console.log("Details do not match!");
      setError("Details do not match!")
    }
  }

  const Logout = details => {
    setUser({ firstname: "", lastname: "", email: "" });
  }


  return (
    <div className="App">
      {(user.email != "") ? (
        <div className="welcome">
        <h2>Welcome, <span>{user.firstname}</span></h2>
        <button onClick={Logout}>Logout</button>
        </div>
      ) : (
        <LoginForm Login={Login} error={error} />
      )}
    </div>
  );
}

export default App;
