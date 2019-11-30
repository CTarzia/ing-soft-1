class MyToolBarComponent extends React.Component {
  constructor(props) {
    super(props)
  }


  logout = () => {
    this.props.router.navigate("/", {
      cartId: 0,
    })
  }

  render() {
    const {
      router,
      title,
      classes,
      cartId,
    } = this.props

    const current_path = router.current()
    let onclick = () => {}
    let icon = ""

    if (current_path === "/") {
      icon = "home"
      onclick = () => {}
    } else if (current_path === "/catalog") {
      icon = "home"
      onclick = () => router.navigate("/", {
        substrings: [],
        selectedSubstring: "",
      })
    } else if (current_path === "/details") {
      icon = "keyboard_arrow_left"
      onclick = () => router.navigate("/catalog", {
        cartId: cartId,
      })
    } else {
      console.error("Not a valid current path!")
    }


    return (
      <div className={classes.rootToolBar}>
        <AppBar position="static">
          <Toolbar>
            <IconButton
              edge="start"
              className={classes.menuButton}
              color="inherit"
              onClick={onclick}
            >
              <Icon>{icon}</Icon>
            </IconButton>
            <Typography variant="h6" className={classes.title}>
              {title}
            </Typography>
            {current_path != '/' &&
              <IconButton
                edge="end"
                className={classes.menuButton}
                color="inherit"
                onClick={this.logout}
              >
                <Icon>{'logout'}</Icon>
              </IconButton>
            }
          </Toolbar>
        </AppBar>
      </div>
    )
  }

}

// Add style
const MyToolBar = withStyles(styles, {
  withTheme: true
})(MyToolBarComponent)
