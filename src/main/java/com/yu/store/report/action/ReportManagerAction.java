package com.yu.store.report.action;

import java.io.OutputStream;

import org.apache.log4j.Logger;

import report.common.Path;
import report.config.XmlConfigLoader;
import report.core.ReportController;

import com.yu.store.sys.action.BaseAction;

/**
 * @author Kingking Yu
 *
 */
public class ReportManagerAction extends BaseAction{

	private static final long serialVersionUID = -1;
	private Logger log = Logger.getLogger(this.getClass().getName());
	
	private int reportId = 0;
	
	private String[] param = null;

	public String execute(){
		
		XmlConfigLoader load = new XmlConfigLoader();
		ReportController controller = new ReportController();
		
		try {
			OutputStream excelTarget = response.getOutputStream();
			response.setContentType("application/vnd.ms-excel");
            response.addHeader("Content-Disposition", "attachment;Filename=EarSight.xls");
	    	load.loadData(Path.getSrcPath() + "/reportConfig.xml");
			controller.execute(reportId, new Object[]{param});
			controller.generate(excelTarget);
	        excelTarget.close();
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}

	public String[] getParam() {
		return param;
	}

	public void setParam(String[] param) {
		this.param = param;
	}

	public int getReportId() {
		return reportId;
	}

	public void setReportId(int reportId) {
		this.reportId = reportId;
	}
	
}
