import React from 'react';
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import Auth from './screens/Auth';
import Login from './components/Login';
import './App.css';

function App() {
  return (
    <Router>
        <Switch>
          <Route path="/auth">
            <Auth />
          </Route>
          <Route path="/">
            <Login />
          </Route>
        </Switch>
    </Router>
  );
}

export default App;