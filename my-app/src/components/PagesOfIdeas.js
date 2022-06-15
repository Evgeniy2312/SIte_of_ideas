import React, {useEffect, useState} from "react";
import axios from "axios";


const API_URL = "http://localhost:3001/show_all_ideas"

export default function Ideas(){

    const [ideas, setIdeas] = useState([])

    useEffect(() => {
        fetchIdeas()
    }, [])

    async function fetchIdeas() {
        try {
            const response = await axios.get(API_URL)
            setIdeas(response.data)
        } catch (e) {
            alert(e)
        }
    }
    return (
        <div>
            <h1>There are all ideas</h1>
            {ideas.map(idea => (
                <div key={idea.id}>
                    <h1>{idea.description}</h1>
                    <p>{idea.sphere}</p>
                    <p>{idea.location}</p>
                    <p>{idea.problem}</p>
                    <p>{idea.team}</p>
                    <p>{idea.plans}</p>
                    <p>{idea.necessary}</p>
                    <div style={{border: "solid 1px"}}/>
                </div>
            ))}
        </div>);
}
