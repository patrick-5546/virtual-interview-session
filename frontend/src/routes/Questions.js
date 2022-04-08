function Questions(data) {

    console.log(data);
    var props = data.data;
    return (
      <div className="container-fluid">
        <h3>Your Questions:</h3>
        <div className="container">
          <div className="row">
            <div className="col">
              <h4>
                {props["question"] ? `Question-1: ${props["question"][0]}` : ""}
              </h4>
              <h4>
              {props["question"] ? `Question-2: ${props["question"][1]}` : ""}
              </h4>
              <h4>
              {props["question"] ? `Question-3: ${props["question"][2]}` : ""}
              </h4>
              <h4>
              {props["question"] ? `Question-4: ${props["question"][3]}` : ""}  
              </h4>
              <h4>
              {props["question"] ? `Question-5: ${props["question"][4]}` : ""}
              </h4>
            </div>
          </div>
        </div>
      </div>
    );
  }
  
  export default Questions;
  