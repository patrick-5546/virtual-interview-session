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
              {props["eyecontact"] ? `Eye Contact Score: ${props["eyecontact"]}` : ""}
            </h4>
          </div>
          <div className="row">
            <div className="col">
              <h4>
                {props["sentiment_score"] ?
                  `Sentiment Score: ${props["sentiment_score"]}` : ""}
              </h4>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Metrics;
