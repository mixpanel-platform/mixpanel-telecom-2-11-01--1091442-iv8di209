var path = require('path');

module.exports = {
    entry: './entry.js',
    output: {
        path: __dirname + '/_build',
        filename: 'bundle.js',
    },
    module: {
        loaders: [
            { test: /\.coffee$/, loader: 'coffee' },
            { test: /\.css$/, loader: 'style!css' },
            { test: /\.jade$/, loader: 'jade' },
            { test: /\.styl$/, loader: 'style!css!stylus' },
            // { test: /\.svg$/, loader: 'svg-url-loader' },
            { test: /\.json$/, loader: 'json' },
            {
                test: /\.(jpe?g|png|gif)$/i,
                // test: /\.(jpe?g|png|gif)$/i,
                loaders: [
                    'url-loader?limit=8192',
                    // 'file?hash=sha512&digest=hex&name=[hash].[ext]',
                    'image-webpack?bypassOnDebug&optimizationLevel=7&interlaced=false',
                ]
            },
        ],
    },
    resolve: {
        root: [
            path.resolve('.'),
            path.resolve('./components'),
            path.resolve('./components/coffeescript')
        ],
        extensions: ['', '.coffee', '.gif', '.jade', '.js', '.json' ,'.jpeg', '.jpg', '.png','.styl', '.svg'],
    }
};
