import { makeStyles, createStyles, Theme } from "@material-ui/core/styles";

export default makeStyles((theme) =>
  createStyles({
    toolbar: {
      width: "100%",
      backgroundColor: theme.palette.common.white,
      display: "flex",
      justifyContent: "space-between",
      zIndex: theme.zIndex.appBar,
    },
    search: {
      marginRight: theme.spacing(1),
    },
    toolbarActions: {
      display: "flex",
      alignItems: "center",
    },
    toolbarAction: {
      marginLeft: theme.spacing(3),
    },
    avatarButton: {
      padding: 4,
    },

    avatar: {
      backgroundColor: theme.palette.primary.main,
    },
    "avatarButton:hover": {
      backgroundColor: "transparent",
    },
  })
);
