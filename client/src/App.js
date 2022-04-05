/* eslint-disable no-sequences */
import React, { useState, useEffect, useRef } from "react";
import axios from "axios";
import LoginForm from "./components/LoginForm";
import Home from "./components/Home";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Metrics from "./routes/Metrics";
import Interview from "./routes/Interview";
import Questions from "./routes/Questions";
import DisplayComponent from './components/DisplayComponent';
import BtnComponent from './components/BtnComponent';

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
  const [question, setQuestion] = useState("");
  const [question2, setQuestion2] = useState("");
  const [question3, setQuestion3] = useState("");
  
  var data2 = {
    question: question
  }
  var data3 = {
    question: question2
  }
  var data4 = {
    question: question3
  }

  /*
  var data = {
    eyecontact: eyecontact,
    sentiment_score: sentiment_score
  }

  const updatedata = (eyecontact, sentiment_score) => {
    setEyecontact(eyecontact);
    setSentimentscore(sentiment_score);
  }
  */
  
  /*
  //const update = () => {
  useEffect(() => {
    axios
      .get(`${APIUrl}/feedback1`)
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
      .get(`${APIUrl}/feedback2`)
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
    */
    //useEffect(update, []);
    

    useEffect(() => {  
      axios
      .get(`${APIUrl}/c`)
      .then(
        (response) => {
          setQuestion([response.data[0].q, response.data[1].q, response.data[2].q, response.data[3].q, response.data[4].q]);
        },
        (reject) => {
          console.log(reject);
        }
      )
      .catch((err) => {
        console.error(err);
      });
      
      axios
      .get(`${APIUrl}/cplus`)
      .then(
        (response) => {
          setQuestion2([response.data[0].q, response.data[1].q, response.data[2].q, response.data[3].q, response.data[4].q]);
        },
        (reject) => {
          console.log(reject);
        }
      )
      .catch((err) => {
        console.error(err);
      });

      axios
      .get(`${APIUrl}/javascript`)
      .then(
        (response) => {
          setQuestion3([response.data[0].q, response.data[1].q, response.data[2].q, response.data[3].q, response.data[4].q]);
        },
        (reject) => {
          console.log(reject);
        }
      )
      .catch((err) => {
        console.error(err);
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

  
  // STATE to store data to pass to Metrics Component (useState = metrics)
  // callback wrapper function to set the state metrics state 
  const [metrics, setMetrics] = useState({}); 

  const updateMetrics = (metrics) => {
    setMetrics(metrics);
  }


  return (
    <Router>
      <div className="App">
        {user.email !== "" ? (
          <div className="welcome">
            <Home user={user} Logout={Logout} updateMetricsProps={updateMetrics}></Home>
            <Routes>
              <Route path="/interview" element={<Interview />}></Route>
              <Route
                path="/feedback"
                element={
                  <Metrics
                    data={metrics}
                  />
                }
              >
                
              </Route>
            <Route path="/interview" element={<Interview />}></Route>
              <Route
                path="/cquestion"
                element={
                  <Questions
                    data={data2}
                  />
                }
              ></Route>
              <Route path="/interview" element={<Interview />}></Route>
              <Route
                path="/cplusquestion"
                element={
                  <Questions
                    data={data3}
                  />
                }
              ></Route>
              <Route path="/interview" element={<Interview />}></Route>
              <Route
                path="/jsquestion"
                element={
                  <Questions
                    data={data4}
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
