module.exports = (app)=>{
    //____________ Routes ________________
    app.use('/api', require('./homePageRouter/homePageRoutes'));
    app.use('/api', require('./filterData/filterData'));
    app.use('/api', require('./users/user'));
    app.use('/api', require('./webPageRouter/webPageRoutes'));
    // app.use('/api', require('./filterData/filterData'));
}


// EVALUATE SUMMARIZECOLUMNS('Date'[Calendar Month],'Location Hierarchy'[Country],'Location Hierarchy'[Division],'Location Hierarchy'[Cluster],'Location Hierarchy'[Site Name],'Channel Hierarchy'[ChannelName], 'Channel Hierarchy'[SubChannelName], 'Product Hierarchy'[CategoryName], 'Product Hierarchy'[BrandName], 'Product Hierarchy'[BFName], 'Product Hierarchy'[SBFName], 'Location Hierarchy'[Branch Name],'Source Of Sales'[Source Of Sale], KEEPFILTERS( FILTER( ALL( 'Date'[Calendar Month] ), SEARCH( "CY2023-Apr", 'Date'[Calendar Month], 1, 0 ) >= 1 )),"FB Points achieved", [FB Points achieved], "FB Target", [FB Target]) ORDER BY 'Date'[Calendar Month] ASC, 'Location Hierarchy'[Country] ASC, 'Location Hierarchy'[Division] ASC, 'Location Hierarchy'[Cluster] ASC, 'Location Hierarchy'[Site Name] ASC, 'Channel Hierarchy'[ChannelName] ASC, 'Channel Hierarchy'[SubChannelName] ASC, 'Product Hierarchy'[CategoryName] ASC, 'Product Hierarchy'[BrandName] ASC, 'Product Hierarchy'[BFName] ASC, 'Product Hierarchy'[SBFName] ASC, 'Location Hierarchy'[Branch Name] ASC, 'Source Of Sales'[Source Of Sale] ASC
