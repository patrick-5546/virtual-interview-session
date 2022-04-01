import React, { useState } from "react";

function LoginForm({ Login, error }) {
    const [details, setDetails] = useState({firstname: "", lastname: "",email: "", password: ""});
    
    const submitHandler = e => {
        e.preventDefault();

        Login(details);
    }

    return(
        <form onSubmit={submitHandler}> 
            <div className="form-inner">
                <h2>Login</h2>
                {(error != "") ? ( <div className="error">{error}</div>) : ""}
                <div className="form-group">
                    <label htmlFor="firstname">First Name:</label>
                    <input type="text" name="firstname" id="firstname" onChange={e => setDetails({...details, firstname: e.target.value })} value={details.firstname}/>
                </div>
                <div className="form-group">
                    <label htmlFor="lastname">Last Name:</label>
                    <input type="text" name="lastname" id="lastname" onChange={e => setDetails({...details, lastname: e.target.value })} value={details.lastname}/>
                </div>
                <div className="form-group">
                    <label htmlFor="email">Email:</label>
                    <input type="email" name="email" id="email"onChange={e => setDetails({...details, email: e.target.value })} value={details.email}/>
                </div>
                <div className="form-group">
                    <label htmlFor="password">Password:</label>
                    <input type="password" name="password" id="password"onChange={e => setDetails({...details, password: e.target.value })} value={details.password}/>
                </div>
                <input type="submit" value="LOGIN" />
            </div>
        </form>
    )
}

export default LoginForm