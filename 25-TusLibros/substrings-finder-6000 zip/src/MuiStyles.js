const theme = createMuiTheme({
  palette: {
    primary: {
      main: '#556cd6',
    },
    secondary: {
      main: '#19857b',
    },
    error: {
      main: colors.red.A400,
    },
    background: {
      default: '#fff',
      paper: '#f5f5f5',
    },
  },
});

const styles = theme => ({
  root: {
    margin: theme.spacing(6, 0, 3),
  },
  lightBulb: {
    verticalAlign: 'middle',
    // marginRight: theme.spacing(1),
  },
  rootToolBar: {
    flexGrow: 1,
  },
  menuButton: {
    marginRight: theme.spacing(2),
  },
  textField: {
    marginTop: theme.spacing(2),
    marginBottom: theme.spacing(2),
  },
  title: {
    flexGrow: 1,
  },
  rootList: {
    width: '100%',
    backgroundColor: theme.palette.background.paper,
    position: 'relative',
    overflow: 'auto',
    maxHeight: 300,
  },
  textFieldDetails: {
    margin: theme.spacing(2),
  },
  catalogListItem: {
    display: 'flex'
  },
  // catalogListItemQty: {
  //   flex: 0 0 auto;
  //   color: rgba(0, 0, 0, 0.54);
  //   padding: 12px;
  //   overflow: visible;
  //   font-size: 1.5rem;
  //   text-align: center;
  //   transition: background-color 150ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;
  //   border-radius: 50%;
  // }
})

const useStyles = makeStyles(styles);
