import React from "react";
import { Link, useLocation } from "react-router-dom";
import useStyles from "./styles";

import BottomNavigation from "@material-ui/core/BottomNavigation";
import BottomNavigationAction from "@material-ui/core/BottomNavigationAction";
import AssessmentIcon from "@material-ui/icons/Assessment";
import AddIcon from "@material-ui/icons/Add";
import LibraryBooksIcon from "@material-ui/icons/LibraryBooks";
import ExitToAppIcon from "@material-ui/icons/ExitToApp";
import LockOpenIcon from "@material-ui/icons/LockOpen";
import { useAuthStateContext } from "../../context/authProvider";
export default function NavBar() {
  const location = useLocation();
  const classes = useStyles();
  const { user } = useAuthStateContext();

  return (
    <BottomNavigation
      value={location.pathname.split("/")[1]}
      showLabels
      className={classes.navigation}
    >
      <BottomNavigationAction
        label="CSV/JSON"
        value="csv-json"
        icon={<AssessmentIcon />}
        component={Link}
        to="/csv-json"
      />
      <BottomNavigationAction
        label="Insertions"
        value="insertions"
        icon={<AddIcon />}
        component={Link}
        to="/insertions"
      />
      <BottomNavigationAction
        label="JuptyerHub"
        icon={<LibraryBooksIcon />}
        onClick={() => window.location.assign(process.env.REACT_APP_JUPTYER)}
      />
      {user?.details?.admin && (
        <BottomNavigationAction
          label="JuptyerHub Authorizer"
          icon={<LockOpenIcon />}
          onClick={() => window.location.assign(`${process.env.REACT_APP_JUPTYER}/hub/authorize`)}
        />
      )}
      <BottomNavigationAction
        label="Logout"
        icon={<ExitToAppIcon />}
        onClick={() => window.location.reload()}
      />
    </BottomNavigation>
  );
}
