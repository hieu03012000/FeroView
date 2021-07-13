import React, { useState } from "react";
import { BrowserRouter as Router, Switch, Route, useHistory, useRouteMatch } from "react-router-dom";
import MenuSidebar from "../components/MenuSidebar";
import Header from "../components/Header";
import Dashboard from "../components/Dashboard";
import ModelDetail from "../components/ModelDetail";
import Calendar from "../components/Calendar";

export default function Auth() {
  let { path } = useRouteMatch();
  const username = localStorage.getItem('username');
  const history = useHistory();
  if (!username) {
    history.replace('/');
  }
  const [zIndex, setZIndex] = useState();
  return (
    <div>
      <MenuSidebar />
      <div className="page-container">
        <Header zIndex={zIndex} />
        <div className="main-content">
          <div className="section__content section__content--p30">
            <div className="container-fluid">
              <Router>
                <Switch>
                  <Route path={`${path}/model/:id/calendar`}>
                    <Calendar />
                  </Route>
                  <Route path={`${path}/model/:id`}>
                    <ModelDetail setZIndex={setZIndex} />
                  </Route>
                  <Route exact path={path}>
                    <Dashboard />
                  </Route>
                </Switch>
              </Router>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}