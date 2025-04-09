//  Created by xudong wu on 24/02/2017.
//  Copyright wuxudong
//

import DGCharts
import SwiftyJSON

class RNLineChartView: RNBarLineChartViewBase {
    let _chart: LineChartView;
    let _dataExtract : LineDataExtract;
    
    override var chart: LineChartView {
        return _chart
    }
    
    override var dataExtract: DataExtract {
        return _dataExtract
    }
    
    override init(frame: CoreGraphics.CGRect) {
        
        self._chart = LineChartView(frame: frame)
        self._dataExtract = LineDataExtract()
        
        super.init(frame: frame);
        
        self._chart.delegate = self
        self.addSubview(_chart);
        
    }

    // Ensure the chart's frame is updated to match the view's bounds during layout updates
    override func layoutSubviews() {
        super.layoutSubviews()
        _chart.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
