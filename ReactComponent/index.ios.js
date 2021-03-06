'use strict';

import React, {
    AppRegistry,
    Component,
    StyleSheet,
    Text,
    View,
    Image,
    ListView,
    TouchableHighlight,
    Alert,
    NativeModules,
} from 'react-native';

var API_KEY = '7waqfqbprs7pajbz28mqf6vz';
var API_URL = 'http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json';
var PAGE_SIZE = 50;
var PARAMS = '?apikey=' + API_KEY + '&page_limit=' + PAGE_SIZE;
var REQUEST_URL = API_URL + PARAMS;

class AwesomeProject extends Component {

    constructor(props) {
        super(props);
        this.renderMovie = this.renderMovie.bind(this);
        this.renderHeader = this.renderHeader.bind(this);
        this.notificationCenter = NativeModules.RNNotificationManager;
        this.state = {
        dataSource: new ListView.DataSource({
                                            rowHasChanged: (row1, row2) => row1 !== row2,
                                            }),
        loaded: false,
        };
    }

    componentDidMount() {
        this.fetchData();
    }

    fetchData() {
        fetch(REQUEST_URL)
        .then((response) => response.json())
        .then((responseData) => {
              this.setState({
                            dataSource: this.state.dataSource.cloneWithRows(responseData.movies),
                            loaded: true,
                            });
              })
        .done();
    }

    render() {
        if (!this.state.loaded) {
            return this.renderLoadingView();
        }

        return (
                <ListView
                dataSource={this.state.dataSource}
                renderRow={this.renderMovie}
                renderHeader={this.renderHeader}
                style={styles.listView}
                />
                );
    }

    renderLoadingView() {
        return (
                <View style={styles.container}>
                <Text>
                正在加载电影数据……
                </Text>
                </View>
                );
    }

    renderMovie(movie){
        return (
                <TouchableHighlight onPress={()=>{
                  this._pressRow(movie)
                }}>
                  <View style={styles.container}>
                    <Image
                      source={{uri: movie.posters.thumbnail}}
                      style={styles.thumbnail}
                    />
                    <View style={styles.rightContainer}>
                      <Text style={styles.title}>{movie.title}</Text>
                      <Text style={styles.year}>{movie.year}</Text>
                    </View>
                  </View>
                </TouchableHighlight>
                );
    }

    renderHeader(){
      return (
        <View style={styles.sectionDivider}>
          <Text style={styles.headingText}>{this.props.content}</Text>
        </View>
       );
     }

    _pressRow(movie) {
        this.notificationCenter.postNotification("pushVC", {"k":movie});
    }
}

var styles = StyleSheet.create({
                               container: {
                               flex: 1,
                               flexDirection: 'row',
                               justifyContent: 'center',
                               alignItems: 'center',
                               backgroundColor: '#F5FCFF',
                               },
                               rightContainer: {
                               flex: 1,
                               },
                               thumbnail: {
                               width: 53,
                               height: 81,
                               },
                               title: {
                               fontSize: 20,
                               marginBottom: 8,
                               textAlign: 'center',
                               },
                               year: {
                               textAlign: 'center'
                               },
                               listView: {
                               paddingTop:0,
                               backgroundColor: '#F5FCFF',
                             },
                             sectionDivider: {
                               padding: 8,
                               backgroundColor: '#EEEEEE',
                               alignItems: 'center'
                             },
                             headingText: {
                               flex: 1,
                               fontSize: 24,
                               alignSelf: 'center'
                             }
                               });

AppRegistry.registerComponent('AwesomeProject', () => AwesomeProject);

var MOCKED_MOVIES_DATA = [
                          {title: '标题', year: '2015', posters: {thumbnail: 'http://i.imgur.com/UePbdph.jpg'}},
                          ];
