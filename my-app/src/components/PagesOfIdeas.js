import React, {useEffect, useState} from "react";
import axios from "axios";
import NaviBar from "./NaviBar"
import styles from "../style/card.module.scss";
import {Card} from "react-bootstrap";
import {useNavigate} from "react-router-dom";
import {getToken} from "../jwt_functions";


const API_URL = "http://localhost:3001/show_all_ideas"

export default function Ideas() {

    const [ideas, setIdeas] = useState([])
    const history = useNavigate();

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
        } catch (e) {
            alert(e.message)
            history("/login")
        }
    }

    return (
        <>
            <NaviBar/>
            <h1 className={styles.header}>There are all ideas</h1>
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
                                <Card.Link href="#">Card Link</Card.Link>
                                <Card.Link href="#">Another Link</Card.Link>
                            </Card.Body>
                        </Card>
                    </div>
                ))}
            </div>
        </>
    );
}
