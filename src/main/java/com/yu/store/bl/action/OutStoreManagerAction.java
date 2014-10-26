package com.yu.store.bl.action;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Type;
import java.net.URLDecoder;
import java.util.List;

import org.apache.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.opensymphony.xwork2.ModelDriven;
import com.yu.store.bl.bo.BrandManagerBO;
import com.yu.store.bl.bo.IntoStoreManagerBO;
import com.yu.store.bl.bo.MemberManagerBO;
import com.yu.store.bl.bo.OutStoreManagerBO;
import com.yu.store.bl.bo.StorageManagerBO;
import com.yu.store.bl.except.OrderCheckException;
import com.yu.store.bl.vo.Brand;
import com.yu.store.bl.vo.IntoStore;
import com.yu.store.bl.vo.Member;
import com.yu.store.bl.vo.OutStore;
import com.yu.store.sys.action.BaseAction;
import com.yu.store.sys.except.SessionEmptyException;
import com.yu.store.sys.util.Tools;

/**
 * @author Kingking Yu
 *
 */
public class OutStoreManagerAction extends BaseAction implements ModelDriven<OutStore>{

	private static final long serialVersionUID = -1;
	private Logger log = Logger.getLogger(this.getClass().getName());
	
	private final String CALLBACK_METHOD = "proxyIntoStoreCallback(?)";
	
	private OutStoreManagerBO outStoreManagerBO = null;
	private StorageManagerBO storageManagerBO = null;
	private BrandManagerBO brandManagerBO = null;
	private IntoStoreManagerBO intoStoreManagerBO = null;
	private MemberManagerBO memberManagerBO = null;
	private OutStore outStore = new OutStore();
	private IntoStore intoStore = new IntoStore();

	public String query(){
		
		try {
			outStoreManagerBO.queryMaxPage(outStore);
			resultList = outStoreManagerBO.queryOutStore(outStore);
			request.setAttribute("outStore", outStore);
		} catch (Exception e) {
			log.error(">>>errors in method:query()", e);
		}
		return "query";
	}
	
	public String proxyQuery(){
		
		PrintWriter out = null;
		Gson son = new Gson();
		String str = null;
		//query condition
		decode();
		intoStore.setDepSerial(outStore.getDepSerial());
		intoStore.setSerial(outStore.getSerial());
		intoStore.setColor(outStore.getColor());
		intoStore.setBeginDate(outStore.getBeginDate());
		intoStore.setEndDate(outStore.getEndDate());
		intoStore.setType(outStore.getType());
		intoStore.setBrand(outStore.getBrand());
		//query condition end

		try {
			response.setContentType("text/html;charset=UTF-8");
			out = response.getWriter();
			resultList = intoStoreManagerBO.queryIntoStoreByOut(intoStore);
			
			if(null == resultList || resultList.size() == 0){
				str = CALLBACK_METHOD.replaceAll("\\?", "");
				return null;
			}
			
			str = son.toJson(resultList);
			str = CALLBACK_METHOD.replaceAll("\\?", str);
			log.info(str);
		} catch (Exception e) {
			log.error(str);
			log.error(e);
		} finally{
			out.print(str);
			out.flush();
			out.close();
			out = null;
		}
		
		return null;
	}
	
	public String gotoDtl(){
		
		try {
			if("order".equals(this.getOptype())){
				resultList = outStoreManagerBO.queryOutStoreDtl(outStore);
				request.setAttribute("outStore", outStore);
				return "order";
			} 
			
			if("orderDtl".equals(this.getOptype())) {
				resultList = outStoreManagerBO.queryOutStoreDtl(outStore);
				
				if(null == resultList || resultList.size() == 0){
					return null;
				}
				
				request.setAttribute("outStore", resultList.get(0));
				return "orderDtl";
			} 
			
			if("add".equals(this.getOptype())) {
				resultList = intoStoreManagerBO.queryIntoStoreByOut(intoStore);
				return "add";
			}
			
		} catch (Exception e) {
			log.error(">>>errors in method:gotoDtl", e);
		}
		return null;
	}
	
	public String insert(){
		
		try {
			Type type = new TypeToken<List<OutStore>>(){}.getType();
			Gson gson = new Gson();
			outStore.setOperator((String)session.get("loginName"));
			decode();
			if(!"".equals(outStore.getMemberId())){
				Member tmpMember = memberManagerBO.queryMemberDtl(outStore.getMemberId());
				if(null == tmpMember){
					jsContent.setAlert("该会员号不存在!");
					return "proxy";
				}
			}
			List<OutStore> list = gson.fromJson(outStore.getParams(), type);
			outStoreManagerBO.insertOutStore(outStore, list);
		} catch (OrderCheckException e) {
			jsContent.setAlert(e.getMessage());
			return "proxy";
		}  catch (SessionEmptyException e) {
			jsContent.setAlert(e.getMessage());
			return "proxy";
		}   catch (Exception e) {
			log.error("出库失败>>>errors in method:insert()", e);
			jsContent.setAlert("出库失败 ");
			return "proxy";
		}
		log.info("出库成功");
		jsContent.setAlert("出库成功");
        jsContent.setCallingFunction("refresh();");
        jsContent.setCallingFunction("closeWindow();");
		return "proxy";
	}
	
	public String update(){
		
		try {
			outStoreManagerBO.updateOutStore(outStore);
		} catch (Exception e) {
			log.error(">>>errors in method:update()", e);
			jsContent.setAlert("修改失败");
			return "proxy";
		}
		jsContent.setAlert("修改成功");
		jsContent.setCallingFunction("refresh();");
        jsContent.setCallingFunction("closeWindow();");
		return "proxy";
	}
	
	public String updateOrder(){
		
		try {
			outStoreManagerBO.updateOutStoreOrder(outStore);
		} catch (Exception e) {
			log.error(">>>errors in method:update()", e);
			jsContent.setAlert("修改失败");
			return "proxy";
		}
		jsContent.setAlert("修改成功");
		jsContent.setCallingFunction("refreshDlg();");
        jsContent.setCallingFunction("closeWindow();");
		return "proxy";
	}

	public String del(){
		
		try {
			int res = outStoreManagerBO.deleteOutStore(outStore.getId());
			if(res == 1){
				info = "删除成功";
			}else if(res == 0){
				info = "无删除数据";
			}
			log.info(outStore.getId() + info);
		} catch (Exception e) {
			log.error(">>>errors in method:del():" + outStore.getId(), e);
			info = "删除失败(该商品已出库)";
		}
		return query();
	}
	
	public String proxyBrand(){
		
		Brand b = null;
		String serial = outStore.getSerial();
		String brand = "无关联信息";
		String type = "无关联信息";
		
		if(null == serial || "".equals(serial.trim())){
			return "proxy";
		}
		
		b = brandManagerBO.queryBrandDtl(serial);
		
		if(null != b){
			brand = b.getBrand() == null ? "无关联信息" : b.getBrand();
			type = b.getType() == null ? "无关联信息" : b.getType();
		} 
		
		jsContent.setCallingFunction("proxyBrandCallback('" + brand + "','"
															+ type + "')");
		return "proxy";
	}
	
	private void decode(){
		try {
			
			if(Tools.isValid(outStore.getColor())){
				outStore.setColor((URLDecoder.decode(outStore.getColor(), "UTF-8")));
			}
			
			if(Tools.isValid(outStore.getType())){
				outStore.setType((URLDecoder.decode(outStore.getType(), "UTF-8")));
			}
			
			if(Tools.isValid(outStore.getBrand())){
				outStore.setBrand((URLDecoder.decode(outStore.getBrand(), "UTF-8")));
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	public OutStoreManagerBO getOutStoreManagerBO() {
		return outStoreManagerBO;
	}

	public void setOutStoreManagerBO(OutStoreManagerBO outStoreManagerBO) {
		this.outStoreManagerBO = outStoreManagerBO;
	}

	public StorageManagerBO getStorageManagerBO() {
		return storageManagerBO;
	}

	public void setStorageManagerBO(StorageManagerBO storageManagerBO) {
		this.storageManagerBO = storageManagerBO;
	}
	
	public BrandManagerBO getBrandManagerBO() {
		return brandManagerBO;
	}

	public void setBrandManagerBO(BrandManagerBO brandManagerBO) {
		this.brandManagerBO = brandManagerBO;
	}
	
	public IntoStoreManagerBO getIntoStoreManagerBO() {
		return intoStoreManagerBO;
	}

	public void setIntoStoreManagerBO(IntoStoreManagerBO intoStoreManagerBO) {
		this.intoStoreManagerBO = intoStoreManagerBO;
	}

	public MemberManagerBO getMemberManagerBO() {
		return memberManagerBO;
	}

	public void setMemberManagerBO(MemberManagerBO memberManagerBO) {
		this.memberManagerBO = memberManagerBO;
	}

	@Override
	public OutStore getModel() {
		return outStore;
	}

}
