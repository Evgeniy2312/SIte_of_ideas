import React, {useEffect, useState} from "react";
import axios from "axios";
import NaviBar from "./NaviBar"
import styles from "../style/card.module.scss";
import {Card} from "react-bootstrap";
import {useNavigate} from "react-router-dom";
import {getToken} from "../jwt_functions";


const API_URL = "http://localhost:3001/idea"

export default function UserIdeas() {

    const [ideas, setIdeas] = useState([])
    const history = useNavigate();
    const currentUser = JSON.parse(localStorage.getItem("currentUser"));

    useEffect(() => {
        fetchIdeas();
    }, [])

    async function fetchIdeas() {
        try {
            let response = await axios.get(API_URL, {
                headers: {
                    "Content-Type": "application/json",
                    "Authorization": getToken(),
                },
            })
            setIdeas(response.data)
            console.log(response.data)
        } catch (e) {
            alert(e.message)
            history("/login")
        }
    }


    return (
        <>
            <NaviBar/>
            <h1 className={styles.header}>Your ideas</h1>
            <div className={styles.card_display}>
                {ideas.map(idea => (
                    <div key={idea.id}>
                        <Card style={{width: '18rem'}}>
                            <Card.Body>
                                <Card.Title>{idea.name}</Card.Title>
                                <Card.Subtitle className="mb-2 text-muted">{idea.location}</Card.Subtitle>
                                <Card.Text>
                                    {idea.description}
                                </Card.Text>
                                {currentUser.role === "entrepreneur" &&
                                    <>
                                        <Card.Link
                                            href={`http://localhost:3001/update_idea/${idea.id}`}>Update</Card.Link>
                                        <Card.Link href="#" onClick={(e) => {
                                            e.preventDefault();
                                            axios.delete(`http://localhost:3001/idea/${idea.id}`, {
                                                headers: {
                                                    "Content-Type": "application/json",
                                                    "Authorization": getToken(),
                                                },
                                            }).then((res) => {
                                                console.log("Delete")
                                                history('/my_ideas')
                                            }).catch((err) => {
                                                    alert(err.message);
                                                    history ("/login")
                                                }
                                            );
                                        }
                                        }>Delete</Card.Link>
                                    </>
                                }
                            </Card.Body>
                        </Card>
                    </div>
                ))}
            </div>
        </>
    );
}
