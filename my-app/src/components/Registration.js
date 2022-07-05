import React, {useState} from 'react'

import axios from "axios";
import NaviBar from "./NaviBar";
import styles from "../style/form.module.scss";
import {Button, Form} from "react-bootstrap";

export default function Registration() {

    let [email, setEmail] = useState("email")
    let [password, setPassword] = useState("password")
    let [confirmPassword, setConfirmPassword] = useState("confirm password")
    let [name, setName] = useState("name")
    let [role, setRole] = useState("investor")
    let [message, setMessage] = useState()


    const handleSubmit = (e) => {
        e.preventDefault();

        const user = {
            email,
            password,
            confirmPassword,
            name,
            role
        };

        axios.post(`http://localhost:3001/signup`, { user })
            .then(res => {
                console.log(res);
                setMessage(res.data.status.message);
            })
            .catch(res => {
                setMessage(res.response.data);
                console.log(res.response)
            })
    }
    return (
        <>
            <NaviBar/>
            <div className={styles.location}>
                <h1>Registration</h1>
                <Form style={{marginTop: "30px"}}>
                    <Form.Group className="mb-3" controlId="formBasicName">
                        <Form.Label>Name</Form.Label>
                        <Form.Control type="text" placeholder="Enter name"
                                      onChange={(e) => {
                                          setName(e.target.value)
                                      }}/>
                    </Form.Group>

                    <Form.Group className="mb-3" controlId="formBasicEmail">
                        <Form.Label>Email address</Form.Label>
                        <Form.Control type="email" placeholder="Enter email"
                                      onChange={(e) => {
                                          setEmail(e.target.value)
                                      }}/>
                        <Form.Text className="text-muted">
                            We'll never share your email with anyone else.
                        </Form.Text>
                    </Form.Group>

                    <Form.Group className="mb-3" controlId="formBasicPassword">
                        <Form.Label>Password</Form.Label>
                        <Form.Control type="password" placeholder="Password"
                                      onChange={(e) => {
                                          setPassword(e.target.value)
                                      }}/>
                    </Form.Group>

                    <Form.Group className="mb-3" controlId="formBasicConfirmPassword">
                        <Form.Label>Confirm password</Form.Label>
                        <Form.Control type="password" placeholder="Confirm password"
                                      onChange={(e) => {
                                          setConfirmPassword(e.target.value)
                                      }}/>
                    </Form.Group>

                    <Form.Group className="mb-3" controlId="formBasicRole">
                        <Form.Label>Role</Form.Label>
                        <Form.Control type="text" placeholder="Default: investor"
                                      onChange={(e) => {
                                          setRole(e.target.value)
                                      }}/>
                    </Form.Group>

                    <Button variant="primary" type={"submit"} onClick={handleSubmit}>
                        Submit
                    </Button>
                </Form>
                <p className={styles.message}>{message}</p>
            </div>
        </>
    )
}



// <div >
//     <div>
//         <h1>Registration Page</h1>
//         <div>Name</div>
//         <div>
//             <input
//                 type={"text"}
//                 onChange={(e) => {
//                     setName(e.target.value)
//                 }}
//             />
//         </div>
//         <div>Email</div>
//         <div>
//             <input
//                 type={"text"}
//                 onChange={(e) => {
//                     setEmail(e.target.value)
//                 }}
//             />
//         </div>
//         <div>Password</div>
//         <div>
//             <input
//                 type={"password"}
//                 onChange={(e) => {
//                     setPassword(e.target.value)
//                 }}
//             />
//         </div>
//         <div>Confirm password</div>
//         <div>
//             <input
//                 type={"password"}
//                 onChange={(e) => {
//                     setConfirmPassword(e.target.value)
//                 }}
//             />
//         </div>
//         <button onClick={handleSubmit}  style={{marginTop: "10px"}}>Submit</button>
//         <div>
//             <p>{message}</p>
//         </div>
//     </div>
// </div>
