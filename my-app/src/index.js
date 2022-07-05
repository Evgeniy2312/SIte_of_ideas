import React from 'react';
import ReactDOM from 'react-dom/client';
import {
    BrowserRouter,
    Routes,
    Route,
} from "react-router-dom";
import App from './App';
import reportWebVitals from './reportWebVitals';
import Login from "./components/Login";
import Registration from "./components/Registration";
import PagesOfIdeas from "./components/PagesOfIdeas";
import Home from "./components/Home"
import About from "./components/About";
import UserIdeas from "./components/UserIdeas";
import UpdateIdea from "./components/idea/UpdateIdea";


const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
    <React.StrictMode>
        <BrowserRouter>
            <Routes>
                <Route path="/" element={<App/>}/>
                <Route path="/login" element={<Login/>}/>
                <Route path="/registration" element={<Registration/>}/>
                <Route path="/ideas" element={<PagesOfIdeas/>}/>
                <Route path="/home" element={<Home/>}/>
                <Route path="/my_ideas" element={<UserIdeas/>}/>
                <Route path="/update_idea/:idea_id" element={<UpdateIdea/>}/>
                <Route path="/about" element={<About/>}/>
            </Routes>
        </BrowserRouter>
    </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();


// <Route path="teams" element={<Teams />}>
//     <Route path=":teamId" element={<Team />} />
//     <Route path="new" element={<NewTeamForm />} />
//     <Route index element={<LeagueStandings />} />
// </Route>
