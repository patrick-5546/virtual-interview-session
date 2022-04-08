import React, { useState, useEffect } from "react";
const APIUrl = "http://34.222.245.107:5000/api";
function Metrics(data) {


  console.log(data);
  var props = data.data;
  return (
    <div className="container-fluid">
      <h3>Your Results:</h3>
      <div className="container">
        <div className="row">
          <div className="col">
            <h4>
              {props["eyecontact"] ? `Average Eye Contact Score: ${props["eyecontact"]}` : ""}
            </h4>
          </div>
          <div className="row">
            <div className="col">
              <h4>
                {props["sentiment_score"] ?
                  ` ${props["sentiment_score"]}`.split(',').map(str => <p>{str}</p>) : ""}
              </h4>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Metrics;
