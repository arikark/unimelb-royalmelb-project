import React from "react";
import { BrowserRouter, Route, Switch, Redirect } from "react-router-dom";
import InsertionPage from "./pages/InsertionPage";
import LoginPage from "./pages/LoginPage";
import CSVPage from "./pages/CSVPage";
import NavBar from "./components/NavBar";
import { useAuthStateContext } from "./context/authProvider";
import Profile from "./components/Profile";

const Main = () => {
  const { user } = useAuthStateContext();
  console.log(user);
  return (
    <BrowserRouter>
      <Switch>
        {!user ? (
          <>
            <Route exact path="/login">
              <LoginPage />
            </Route>
            <Route path="/">
              <Redirect to="/login" />
            </Route>
          </>
        ) : (
          <>
            <div
              style={{
                textAlign: "center",
                display: "flex",
                flexDirection: "column",
                alignItems: true,
              }}
            >
              <span>
                <div
                  style={{
                    display: "flex",
                    flexDirection: "row",
                    justifyContent: "center",
                  }}
                >
                  <h1>Audits</h1>
                  <Profile user={user?.details} />
                </div>
              </span>
              <NavBar style={{ width: "auto" }} />
            </div>

            <Route exact path="/csv-json">
              <CSVPage />
            </Route>
            <Route exact path="/insertions">
              <InsertionPage />
            </Route>
            <Route path="/">
              <Redirect to="/csv-json" />
            </Route>
          </>
        )}
      </Switch>
    </BrowserRouter>
  );
};
export default Main;
