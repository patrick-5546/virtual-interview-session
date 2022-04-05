import React, {useState, useEffect, Component} from "react";
import {Link, useNavigate, BrowserRouter as Router, Routes, Route } from "react-router-dom";
import axios from "axios";
import Box from '@material-ui/core/Box';
import { Button, ButtonGroup } from "@material-ui/core";
import DisplayComponent from './DisplayComponent';
import BtnComponent from './BtnComponent';

import Metrics from "../routes/Metrics";
import Interview from "../routes/Interview";
import Questions from "../routes/Questions";

function Home({ user, Logout, updateMetricsProps }) {

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
              setEyecontact(response.data.feedback);
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
        </div>
        <button onClick={Logout}> <Link to="">Logout</Link></button>
      </nav>
      <div>
        <h1>
          Please select an option to start the interview!
        </h1>
      </div>
      <div style={{ marginLeft: '40%', marginTop: '60px' }}></div>
      <ButtonGroup aria-label="outlined primary button group">
      <Box color="black" borderRadius="5px" height="80px" width="150px" bgcolor="orange" p="10px" cursor="pointer" display="flex" justifyContent="center" alignItems="center" fontWeight="bold" style={{cursor:'pointer'}} onClick={() => {routeChangeC(); handleOnClick();}}>
        C 
      </Box>
     </ButtonGroup>
     <ButtonGroup orientation="horizontal" aria-label="outlined primary button group">
     <Box marginLeft="40px" borderRadius="5px" height="80px" width="150px" color="black" bgcolor="orange" p="10px" display="flex" justifyContent="center" alignItems="center" fontWeight="bold" style={{cursor:'pointer'}} onClick={() => {routeChangeCplus(); handleOnClick();}}>
        C++ 
      </Box>
      </ButtonGroup>
      <ButtonGroup orientation="horizontal" aria-label="outlined primary button group">
     <Box marginLeft="40px" borderRadius="5px" height="80px" width="150px" color="black" bgcolor="orange" p="10px" display="flex" justifyContent="center" alignItems="center" fontWeight="bold" style={{cursor:'pointer'}} onClick={() => {routeChangejs(); handleOnClick();}}>
        JavaScript 
      </Box>
      </ButtonGroup>
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
