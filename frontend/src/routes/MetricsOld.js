import React, { useState, useEffect } from "react";
const APIUrl = "http://34.222.245.107:5000/api";
function MetricsOld(data) {


  console.log(data);
  var props = data.data;
  return (
    <div className="container-fluid">
      <h3>Your Previous Results:</h3>
      <div className="container">
        <div className="row">
          <div className="col">
            <h4>
              {props["eyecontactOld"] ? `Average Eye Contact Score: ${props["eyecontactOld"]}` : ""}
            </h4>
          </div>
          <div className="row">
            <div className="col">
              <h4>
                {props["sentiment_scoreOld"] ?
                  ` ${props["sentiment_scoreOld"]}`.split(',').map(str => <p>{str}</p>) : ""}
              </h4>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default MetricsOld;
