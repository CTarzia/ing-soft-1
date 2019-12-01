class HistoryComponent extends React.Component {
    constructor(props) {
      super(props)
  
      this.state = {
        purchases: []
      }
    }

    componentDidMount() {
        let purchases = []
        getLocalAsJson(`listPurchases?clientId=${this.props.user}`)
        .then(function (response) {
            return response.json()
        })
        .then(function (json) {
            purchases = json
        })
        .then(() => {
            this.setState({
                loading: false,
                purchases: purchases
            })
        })
        .catch(err => {
            this.setState({
                loading: false,
                error: err,
            })
        })
    }

    render() {
        return (
            <CheckoutView
                ticket={this.state.purchases}
                catalog={this.props.catalog}
            />
        )
    }
  }
  
  // Add style
  const HistoryView = withStyles(styles, {
    withTheme: true
  })(HistoryComponent)
  