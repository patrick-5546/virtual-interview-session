/* eslint-disable no-sequences */
import React, { useState, useEffect } from "react";
import axios from "axios";
import LoginForm from "./components/LoginForm";
import Home from "./components/Home";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Metrics from "./routes/Metrics";
import Interview from "./routes/Interview";

function App() {
  const adminUser = {
    email: "cpen@admin.com",
    password: "cpen123",
  };

  const APIUrl = "http://34.222.245.107:5000/api";
  const [eyecontact, setEyecontact] = useState("");
  const [sentiment_score, setSentimentscore] = useState("");
  const [user, setUser] = useState({ firstname: "", lastname: "", email: "" });
  const [error, setError] = useState("");

  var data = {
    eyecontact: eyecontact,
    sentiment_score: sentiment_score
  }

  useEffect(() => {
    axios
      .get(`${APIUrl}/feedback`)
      .then(
        (response) => {
          setEyecontact(response.data.feedback);
        },
        (reject) => {
          console.log(reject);
        }
      )
      .catch((err) => {
        console.error(err);
      });
    
      axios
      .get(`${APIUrl}/feedback`)
      .then(
        (response) => {
          setSentimentscore(response.data.feedback);
        },
        (reject) => {
          console.log(reject);
        }
      )
      .catch((err) => {
        console.log(err);
      });
  }, []);

  const Login = (details) => {
    console.log(details);

    if (
      details.email === adminUser.email &&
      details.password === adminUser.password
    ) {
      console.log("Logged in");
      setUser({
        firstname: details.firstname,
        lastname: details.lastname,
        email: details.email,
      });
    } else {
      console.log("Details do not match!");
      setError("Details do not match!");
    }
  };

  const Logout = (details) => {
    setUser({ firstname: "", lastname: "", email: "" });
  };

  return (
    <Router>
      <div className="App">
        {user.email !== "" ? (
          <div className="welcome">
            <Home user={user} Logout={Logout}></Home>
            <Routes>
              <Route path="/interview" element={<Interview />}></Route>
              <Route
                path="/feedback"
                element={
                  <Metrics
                    data={data}
                  />
                }
              ></Route>
            </Routes>
          </div>
        ) : (
          <Routes>
            <Route
              path="/"
              element={<LoginForm Login={Login} error={error} />}
            ></Route>
          </Routes>
        )}
      </div>
    </Router>
  );
}

export default App;
