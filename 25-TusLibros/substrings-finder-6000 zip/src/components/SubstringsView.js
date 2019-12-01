class SubstringsComponent extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      catalog: props.catalog,
      cartItems: [],
      refresh: false
    }
  }

  componentDidMount() {
    this.listCart()
    
  }

  listCart = () => {
    this.setState({
      loading: true,
      error: null,
      refresh: false
    })
    let cartItems = []

    getLocalAsJson(`listCart?cartId=${this.props.cartId}`)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        cartItems = json
      })
      .then((details) => {
        this.setState({
          loading: false,
          cartItems: cartItems
        })
      })
      .catch(err => {
        this.setState({
          loading: false,
          error: err,
        })
      })
  }

  getItemQty = (isbn) => {
    const total = this.state.cartItems.reduce((accum, curr) => {
      if(curr == isbn) {
        return accum + 1
      }
      return accum
    }, 0)
    return total
  }

  checkout = () => {
    let ticket = []
    getLocalAsJson(`checkOutCart?cartId=${this.props.cartId}`)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        ticket = json
      })
      .then((details) => {
        this.props.router.navigate("/checkout", {ticket, cartId: 0})
      })
      .catch(err => {
        this.setState({
          loading: false,
          error: err,
        })
      })
  }

  render() {
    if (this.state.loading) return <div>Loading...</div>
    const {
      router,
      cartId,
      classes,
      cartView
    } = this.props
    return (
      <div>
        <Typography component="h1" gutterBottom>
          {cartView ? 'Carrito:' :  'Catalogo:'}
          </Typography>
        <List component="nav" className={classes.rootList} >
          {
            this.state.catalog.map((item) => {
              return (
                <CatalogItem
                  item={item}
                  key={item.isbn}
                  classes={classes}
                  getItemQty={this.getItemQty}
                  router={router}
                  cartId={this.props.cartId}
                  cartView={cartView}
                />
              )
            })
          }
        </List>
        { cartView &&
          <Button onClick={this.checkout}>
            Checkout
          </Button>
        }
      </div>
    )
  }
}



class CatalogItem extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      quantity: props.getItemQty(props.item.isbn)
    }

  }

  add = () => {
    getLocalAsJson(`addToCart?cartId=${this.props.cartId}&bookIsbn=${this.props.item.isbn}&bookQuantity=1`)
      .then(() => {
        this.setState({
          quantity: this.state.quantity + 1,
        })
      })
      .catch(err => {
        this.setState({
          error: err,
        })
      })

  }

  remove = () => {
    getLocalAsJson(`removeFromCart?cartId=${this.props.cartId}&bookIsbn=${this.props.item.isbn}`)
      .then(() => {
        this.setState({
          quantity: this.state.quantity - 1,
        })
      })
      .catch(err => {
        this.setState({
          error: err,
        })
      })

  }

  details = () => {
    this.props.router.navigate("/details", { item: this.props.item, quantity: this.state.quantity })
  }

  render() {
    const {
      router,
      item,
      classes,
      cartView
    } = this.props
    if (cartView && this.state.quantity == 0) return null
    return (
      <ListItem
        key={item.isbn}
        button
        onClick={this.details}
      >
        <ListItemText primary={item.title} secondary={item.isbn} />
          <ListItemSecondaryAction
            className={classes.catalogListItem}             
          >
            <IconButton
              onClick={this.remove}
            >
              -
            </IconButton>
            <IconButton disabled>{this.state.quantity}</IconButton>
            <IconButton
              onClick={this.add}
            >
              +
            </IconButton>
          </ListItemSecondaryAction>
      </ListItem>      
    )
  }
}

// Add style
const SubstringsView = withStyles(styles, {
  withTheme: true
})(SubstringsComponent)
