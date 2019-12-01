class MyToolBarComponent extends React.Component {
  constructor(props) {
    super(props)
  }


  logout = () => {
    this.props.router.navigate("/", {
      cartId: 0,
    })
  }

  goToCart = () => {
    this.props.router.navigate("/cart", {
    })
  }

  goToCatalog = () => { 
    this.props.router.navigate("/catalog", {
      cartId: this.props.cartId,
    })
  }


  goToHistory = () => this.props.router.navigate("/history", {
  })

  render() {
    const {
      router,
      title,
      classes,
      cartId,
    } = this.props

    const current_path = router.current()

    return (
      <div className={classes.rootToolBar}>
        <AppBar position="static">
          <Toolbar>
            {!!cartId && current_path != '/catalog' &&
              <IconButton
                edge="start"
                className={classes.menuButton}
                color="inherit"
                onClick={this.goToCatalog}
              >
                <Icon>{'menu_book'}</Icon>
              </IconButton>
            }
            {!!cartId && current_path != '/cart' &&
              <IconButton
                edge="start"
                className={classes.menuButton}
                color="inherit"
                onClick={this.goToCart}
              >
                <Icon>{'shopping_cart'}</Icon>
              </IconButton>
            }
            {current_path != '/' && current_path != '/history' &&
              <IconButton
                edge="start"
                className={classes.menuButton}
                color="inherit"
                onClick={this.goToHistory}
              >
                <Icon>{'history'}</Icon>
              </IconButton>
            }
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
