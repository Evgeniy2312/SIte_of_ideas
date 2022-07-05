import React, {useEffect, useState} from 'react'
import {useNavigate, useParams} from "react-router-dom";
import axios from "axios";
import {Button, Form} from "react-bootstrap";
import NaviBar from "../NaviBar";
import styles from "../../style/form.module.scss"
import {getToken} from "../../jwt_functions"

export default function UpdateIdea() {


    const history = useNavigate();
    let [name, setName] = useState("")
    let [description, setDescription] = useState("")
    let [sphere, setSphere] = useState("")
    let [location, setLocation] = useState("")
    let [problem, setProblem] = useState("")
    let [necessary, setNecessary] = useState("")
    let [team, setTeam] = useState("")
    let [plans, setPlans] = useState("")
    let [message, setMessage] = useState("")
    const {idea_id} = useParams();


    useEffect(() => {
        testUser()
    }, [])


    function testUser(){
        const currentUser = JSON.parse(localStorage.getItem("currentUser"))
        if (currentUser.role === "entrepreneur") {
            let flag = false;
            currentUser.ideas.forEach(idea => {
                console.log(flag)
                if (idea.id === Number(idea_id)) {
                    flag = true
                }
            })
            if (!flag) {
                history("/ideas")
            }
        }
        history("/ideas")
    }

    const handleSubmit = async (e) => {
        e.preventDefault();


        const idea = {
            name,
            description,
            sphere,
            location,
            problem,
            necessary,
            team,
            plans
        };


        await axios.put(`http://localhost:3001/idea/${idea_id}`, {idea}, {
            headers: {
                "Content-Type": "application/json",
                "Authorization": getToken(),
            },
        })
            .then(res => {
                console.log(res)
                history('/my_ideas')
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
                <h1>Update Idea</h1>
                <Form style={{marginTop: "30px"}}>
                    <Form.Group className="mb-2" controlId="formBasicName">
                        <Form.Label>Name</Form.Label>
                        <Form.Control type="text" placeholder="Name"
                                      onChange={(e) => {
                                          setName(e.target.value)
                                      }}/>
                    </Form.Group>

                    <Form.Group className="mb-2" controlId="formBasicDescription">
                        <Form.Label>Description</Form.Label>
                        <Form.Control type="text" placeholder="Description"
                                      onChange={(e) => {
                                          setDescription(e.target.value)
                                      }}/>
                    </Form.Group>

                    <Form.Group className="mb-2" controlId="formBasicSphere">
                        <Form.Label>Sphere</Form.Label>
                        <Form.Control type="text" placeholder="Sphere"
                                      onChange={(e) => {
                                          setSphere(e.target.value)
                                      }}/>
                    </Form.Group>

                    <Form.Group className="mb-2" controlId="formBasicLocation">
                        <Form.Label>Location</Form.Label>
                        <Form.Control type="text" placeholder="Location"
                                      onChange={(e) => {
                                          setLocation(e.target.value)
                                      }}/>
                    </Form.Group>

                    <Form.Group className="mb-2" controlId="formBasicProblem">
                        <Form.Label>Problem</Form.Label>
                        <Form.Control type="text" placeholder="Problem"
                                      onChange={(e) => {
                                          setProblem(e.target.value)
                                      }}/>
                    </Form.Group>

                    <Form.Group className="mb-2" controlId="formBasicNecessary">
                        <Form.Label>Necessary</Form.Label>
                        <Form.Control type="text" placeholder="Necessary"
                                      onChange={(e) => {
                                          setNecessary(e.target.value)
                                      }}/>
                    </Form.Group>

                    <Form.Group className="mb-2" controlId="formBasicTeam">
                        <Form.Label>Team</Form.Label>
                        <Form.Control type="text" placeholder="Team"
                                      onChange={(e) => {
                                          setTeam(e.target.value)
                                      }}/>
                    </Form.Group>

                    <Form.Group className="mb-2" controlId="formBasicPlans">
                        <Form.Label>Plans</Form.Label>
                        <Form.Control type="text" placeholder="Plans"
                                      onChange={(e) => {
                                          setPlans(e.target.value)
                                      }}/>
                    </Form.Group>
                    <Button variant="primary" type={"submit"} onClick={handleSubmit}>
                        Update
                    </Button>
                </Form>
                <p className={styles.message}>{message}</p>
            </div>
        </>
    )
}

