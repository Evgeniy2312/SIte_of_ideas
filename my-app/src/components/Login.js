import React, {useState} from 'react'
import {useNavigate} from "react-router-dom";
import axios from "axios";
import {Form, Button} from "react-bootstrap";
import NaviBar from "./NaviBar";
import styles from "../style/form.module.scss"
import { setToken, getToken } from "../jwt_functions"

export default function Login() {


    const history = useNavigate();
    let [email, setEmail] = useState("eevvv@gmail.com")
    let [password, setPassword] = useState("12345678")
    let [message, setMessage] = useState()


    async function getCurrentUser(){

        await axios.get(`http://localhost:3001/current_user`,{
            headers: {
                "Content-Type": "application/json",
                "Authorization": getToken()
            },
        })
            .then(res => {
                console.log(res)
                const currentUser = {
                    name: res.data.name,
                    role: res.data.role,
                    email: res.data.email,
                    id: res.data.id,
                    ideas: res.data.ideas
                }
                localStorage.setItem("currentUser",  JSON.stringify(currentUser))
            })
            .catch(res => {
                alert(res.response.message);
            })
    }

    const handleSubmit = async (e) => {
        e.preventDefault();

        const user = {
            email,
            password
        };


        await axios.post(`http://localhost:3001/login`, {user})
            .then(res => {
                setToken(res.headers["authorization"]);
                getCurrentUser()
                history('/ideas')
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
                <h1>Authorization</h1>
                <Form style={{marginTop: "30px"}}>
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
                    <Form.Group className="mb-3" controlId="formBasicCheckbox">
                        <Form.Check type="checkbox" label="Check me out"/>
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
