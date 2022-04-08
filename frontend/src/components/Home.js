import React, {useState, useEffect, Component} from "react";
import {Link, useNavigate, BrowserRouter as Router, Routes, Route } from "react-router-dom";
import axios from "axios";
import Box from '@material-ui/core/Box';
import { Button, ButtonGroup } from "@material-ui/core";
import DisplayComponent from './DisplayComponent';
import BtnComponent from './BtnComponent';
import Metrics from "../routes/Metrics";

function Home({ user, Logout, updateMetricsProps, updateMetricsPropsOld }) {

  //Timer//
  const [time, setTime] = useState({ms:0, s:0, m:0});
  const [interv, setInterv] = useState();
  const [status, setStatus] = useState(0);
  // Not started = 0
  // started = 1
  // stopped = 2

  const start = () => {
    run();
    setStatus(1);
    setInterv(setInterval(run, 10));

    axios
    .get(`${APIUrl}/start`)
    .then(
      (response) => {
      },
      (reject) => {
        console.log(reject);
      }
    )
    .catch((err) => {
      console.error(err);
    });

  };

  var updatedMs = time.ms, updatedS = time.s, updatedM = time.m;

  const run = () => {
    if(updatedM === 60){
      //updatedH++;
      if(updatedM === 5) {
        setStatus(2);
      }
    }
    if(updatedS === 60){
      updatedM++;
      updatedS = 0;
    }
    if(updatedMs === 100){
      updatedS++;
      updatedMs = 0;
    }
    updatedMs++;
    return setTime({ms:updatedMs, s:updatedS, m:updatedM});
  };

  const stop = () => {
    clearInterval(interv);
    setStatus(2);

    axios
    .get(`${APIUrl}/stop`)
    .then(
      (response) => {
      },
      (reject) => {
        console.log(reject);
      }
    )
    .catch((err) => {
      console.error(err);
    });
  };

  const reset = () => {
    clearInterval(interv);
    setStatus(0);
    setTime({ms:0, s:0, m:0, h:0})
  };

  const resume = () => start();


  let navigate = useNavigate(); 
  const routeChangeC = () =>{ 
    let path = `/cquestion`; 
    navigate(path);
  }

  const routeChangeCplus = () =>{ 
    let path = `/cplusquestion`; 
    navigate(path);
  }

  const routeChangejs = () =>{ 
    let path = `/jsquestion`; 
    navigate(path);
  }

  const routeChangePy = () =>{ 
    let path = `/python`; 
    navigate(path);
  }

  const routeChangeHw = () =>{ 
    let path = `/hardware`; 
    navigate(path);
  }

  const routeChangeB = () =>{ 
    let path = `/behavioural`; 
    navigate(path);
  }

  const [show, setShow] = useState(false);
    const handleOnClick = () => {
        setShow(true);
    }
  
  const [eyecontact, setEyecontact] = useState("");
  const [sentiment_score, setSentimentscore] = useState("");

  
  var data = {
    eyecontact: eyecontact,
    sentiment_score: sentiment_score
  }

  const [eyecontactOld, setEyecontactOld] = useState("");
  const [sentiment_scoreOld, setSentimentscoreOld] = useState("");

  
  var dataOld = {
    eyecontactOld: eyecontactOld,
    sentiment_scoreOld: sentiment_scoreOld
  }

  const updatedata = (eyecontact, sentiment_score) => {
    setEyecontact(eyecontact);
    setSentimentscore(sentiment_score);
  }
  
    
  const APIUrl = "http://34.222.245.107:5000/api";
    
    
    const update = () => {
      //useEffect(() => {
        axios
          .get(`${APIUrl}/feedback1`)
          .then(
            (response) => {
              setEyecontact(response.data);
              axios
              .get(`${APIUrl}/feedback2`)
              .then(
                (response) => {
                  setSentimentscore(response.data.feedback);
                  updateMetricsProps(data);
                }
              )
            },
            (reject) => {
              console.log(reject);
            }
          )
          .catch((err) => {
            console.error(err);
          });
        }

        const old = () => {
          //useEffect(() => {
            axios
              .get(`${APIUrl}/feedback3`)
              .then(
                (response) => {
                  setEyecontactOld(response.data);
                  axios
                  .get(`${APIUrl}/feedback4`)
                  .then(
                    (response) => {
                      setSentimentscoreOld(response.data.feedback);
                      updateMetricsPropsOld(dataOld);
                    }
                  )
                },
                (reject) => {
                  console.log(reject);
                }
              )
              .catch((err) => {
                console.error(err);
              });
            }

  return (
    <div>
      <nav className="navbar navbar-expand-lg navbar-light bg-light">
        <div className="container-fluid">
          <h2>
            Welcome, <span>{user.firstname}</span>
          </h2>
          <button type="button" aria-expanded="false" onClick={update}>
            <Link to="/feedback"><span>Feedback </span> </Link>
          </button>
          <button type="button" aria-expanded="false" onClick={old}>
            <Link to="/feedback2"><span>Previous Feedback </span> </Link>
          </button>
        </div>
        <button onClick={Logout}> <Link to="">Logout</Link></button>
      </nav>
      <div>
        <h1>
          Please select an option to start the interview!
        </h1>
      </div>
      <div style={{ marginLeft: '2%', marginTop: '60px'}}>
      <ButtonGroup aria-label="outlined primary button group">
      <Box color="black" borderRadius="30px" height="80px" width="150px" bgcolor="orange" fontSize="24px" p="10px" cursor="pointer" display="flex" justifyContent="center" alignItems="center" fontWeight="bold" style={{cursor:'pointer'}} onClick={() => {routeChangeC(); handleOnClick();}}>
        C 
      </Box>
     </ButtonGroup>
     <ButtonGroup orientation="horizontal" aria-label="outlined primary button group">
     <Box marginLeft="40px" borderRadius="30px" height="80px" width="150px" color="black" bgcolor="orange" fontSize="24px" p="10px" display="flex" justifyContent="center" alignItems="center" fontWeight="bold" style={{cursor:'pointer'}} onClick={() => {routeChangeCplus(); handleOnClick();}}>
        C++ 
      </Box>
      </ButtonGroup>
      <ButtonGroup orientation="horizontal" aria-label="outlined primary button group">
     <Box marginLeft="40px" borderRadius="30px" height="80px" width="200px" color="black" bgcolor="orange" fontSize="24px" p="10px" display="flex" justifyContent="center" alignItems="center" fontWeight="bold" style={{cursor:'pointer'}} onClick={() => {routeChangejs(); handleOnClick();}}>
        JavaScript 
      </Box>
      </ButtonGroup>
      <ButtonGroup orientation="horizontal" aria-label="outlined primary button group">
     <Box marginLeft="40px" borderRadius="30px" height="80px" width="150px" color="black" bgcolor="orange" fontSize="24px" p="10px" display="flex" justifyContent="center" alignItems="center" fontWeight="bold" style={{cursor:'pointer'}} onClick={() => {routeChangePy(); handleOnClick();}}>
        Python 
      </Box>
      </ButtonGroup>
      <ButtonGroup orientation="horizontal" aria-label="outlined primary button group">
     <Box marginLeft="40px" borderRadius="30px" height="80px" width="180px" color="black" bgcolor="orange" fontSize="24px" p="10px" display="flex" justifyContent="center" alignItems="center" fontWeight="bold" style={{cursor:'pointer'}} onClick={() => {routeChangeHw(); handleOnClick();}}>
        Hardware 
      </Box>
      </ButtonGroup>
      <ButtonGroup orientation="horizontal" aria-label="outlined primary button group">
     <Box marginLeft="40px" borderRadius="30px" height="80px" width="200px" color="black" fontSize="24px" bgcolor="orange" p="10px" display="flex" justifyContent="center" alignItems="center" fontWeight="bold" style={{cursor:'pointer'}} onClick={() => {routeChangeB(); handleOnClick();}}>
        Behavioural 
      </Box>
      </ButtonGroup>
      </div>
      <div>
        {show && (<div className="main-section">
            <div className="clock-holder">
            <div className="stopwatch">
               <DisplayComponent time={time}/>
               <BtnComponent status={status} resume={resume} reset={reset} stop={stop} start={start}/>
          </div>
          </div>
          </div>)}
      </div>
    </div>
  );
}

export default Home;
