class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/",
      substrings: [],
      selectedSubstring: "",
      cartId: 0
    };
  }

  render() {
    let title = "Tus Libros"
    let content = "Where am I?"
    const router = {
      current: () => this.state.path,
      navigate: (path, state) => {
        // http://es6-features.org/#SpreadOperator
        this.setState({ ...state, path: path })
      }
    }

    if (this.state.path === "/") {
      content = (<StringInputView
        router={router}
      />)
    } else if (this.state.path === "/catalog") {
      content = (<SubstringsView
        router={router}
        cartId={this.state.cartId}
      />)
    } else if (this.state.path === "/details") {
      content = (<SubstringDetailsView
        router={router}
        item={this.state.item}
        quantity={this.state.quantity}
      />)
    }
    return (
      <div>
        <MyToolBar
          title={title}
          router={router}
          cartId={this.state.cartId}
        />
        <Container maxWidth="sm">
          <div style={{ marginTop: 24, }}>
            {content}
          </div>
        </Container>
      </div>
    );
  }
}
