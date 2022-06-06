import React, {useState} from 'react'
import {NavLink} from "react-router-dom";
import axios from "axios";

export const Login = () => {

    const history = useHistory()

    let [email, setEmail] = useState("email")
    let [password, setPassword] = useState("password")
    let [confirmPassword, setConfirmPassword] = useState("confirm password")
    let [name, setName] = useState("name")
    let [message, setMessage] = useState()


    const handleSubmit = (e) => {
        e.preventDefault();

        const user = {
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            name: name
        };

        // axios.post(`http://localhost:3001/login`, { user })
        //     .then(res => {
        //         console.log(res);
        //         console.log(res);
        //         setMessage(res.data.status.message);
        //     })
        //     .catch(res => {
        //         setMessage(res.response.data);
        //         console.log(res.response)
        //     })
    }
    return (
        <div >
            <div>
                <h1>Registration Page</h1>
                <div>Name</div>
                <div>
                    <input
                        type={"text"}
                        onChange={(e) => {
                            setName(e.target.value)
                        }}
                    />
                </div>
                <div>Email</div>
                <div>
                    <input
                        type={"text"}
                        onChange={(e) => {
                            setEmail(e.target.value)
                        }}
                    />
                </div>
                <div>Password</div>
                <div>
                    <input
                        type={"password"}
                        onChange={(e) => {
                            setPassword(e.target.value)
                        }}
                    />
                </div>
                <div>Confirm password</div>
                <div>
                    <input
                        type={"password"}
                        onChange={(e) => {
                            setConfirmPassword(e.target.value)
                        }}
                    />
                </div>
                <button onClick={handleSubmit}  style={{marginTop: "10px"}}>Submit</button>
                <div>
                    <p>{message}</p>
                </div>
            </div>
        </div>
    )
}

