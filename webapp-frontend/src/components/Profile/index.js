import React from "react";
import clsx from "clsx";

import IconButton from "@material-ui/core/IconButton";
import Avatar from "@material-ui/core/Avatar";

import useStyles from "./styles";

import List from "@material-ui/core/List";
import ListItem from "@material-ui/core/ListItem";
import ListItemAvatar from "@material-ui/core/ListItemAvatar";
import ListItemText from "@material-ui/core/ListItemText";
import DialogTitle from "@material-ui/core/DialogTitle";
import Dialog from "@material-ui/core/Dialog";
import PersonIcon from "@material-ui/icons/Person";
import AddIcon from "@material-ui/icons/Add";
import Typography from "@material-ui/core/Typography";
import { Button, DialogActions, DialogContent } from "@material-ui/core";

const Profile = ({ user }) => {
  const classes = useStyles();
  const [open, setOpen] = React.useState(false);

  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = (value) => {
    setOpen(false);
  };

  return (
    <>
      <IconButton
        className={clsx(classes.toolbarAction, classes.avatarButton)}
        style={{ backgroundColor: "transparent" }}
        onClick={handleClickOpen}
      >
        <Avatar className={classes.avatar}></Avatar>
      </IconButton>
      <Dialog onClose={handleClose} open={open}>
        <DialogTitle>Profile</DialogTitle>
        <DialogContent style={{ width: "30rem" }}>
          <DialogContent dividers>
            <Typography gutterBottom>
              <b>Name:</b> {user.name ? user.name : "N/A"}
            </Typography>
            <Typography gutterBottom>
              <b>Admin Access:</b> {user.admin ? "Yes" : "No"}
            </Typography>
            <Typography gutterBottom>
              <b>User Created:</b> {user.created ? Date(user.created) : "N/A"}
            </Typography>
            <Typography gutterBottom>
              <b>User Type:</b> {user.kind ? user.kind : "N/A"}
            </Typography>
          </DialogContent>
          <DialogActions>
            <Button autoFocus onClick={handleClose} color="primary">
              Close
            </Button>
          </DialogActions>
        </DialogContent>
      </Dialog>
    </>
  );
};
export default Profile;
