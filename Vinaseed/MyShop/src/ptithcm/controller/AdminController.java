package ptithcm.controller;

import java.text.DecimalFormat;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import ptithcm.entity.OrderDetail;
import ptithcm.entity.TheOrder;

@Transactional
@Controller
@RequestMapping("/admin/")
public class AdminController {
	@Autowired
	SessionFactory factory;

	public String getTongGiaVN(Float a) {
		DecimalFormat formatter = new DecimalFormat("###,###,###");
		return formatter.format(a) + " VNĐ";

	}
	@RequestMapping("theorder")
	public String theorder(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "FROM TheOrder WHERE StatusOrder='1'";
		Query query = session.createQuery(hql);
		List<TheOrder> list = query.list();
		model.addAttribute("TheOrderNew", list);
		return "admin/theorder";
	}

	@RequestMapping("theorderCommit")
	public String theOrderCommit(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "FROM TheOrder WHERE StatusOrder='2' OR StatusOrder='0'";
		Query query = session.createQuery(hql);
		List<TheOrder> list = query.list();
		model.addAttribute("TheOrderNew", list);
		return "admin/theOrderCommit";
	}

	@RequestMapping(value = "receive/{idOrder}")
	public String receive(ModelMap model, @PathVariable("idOrder") String idOrder) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			String hql = "FROM TheOrder WHERE idOrder=" + idOrder;
			Query query = session.createQuery(hql);
			List<TheOrder> list = query.list();
			TheOrder temp = list.get(0);
			temp.setStatusOrder("2");
			session.update(temp);
			t.commit();
			model.addAttribute("message", "Tiếp nhận thành công");
		} catch (Exception e) {
			// TODO: handle exception
			t.rollback();
			model.addAttribute("message", "Tiếp nhận không thành công");
		} finally {
			session.close();
		}
		Session session2 = factory.getCurrentSession();
		String hql2 = "FROM TheOrder WHERE StatusOrder='1'";
		Query query2 = session2.createQuery(hql2);
		List<TheOrder> list2 = query2.list();
		model.addAttribute("TheOrderNew", list2);
		return "admin/theorder";
	}

	@RequestMapping(value = "showDetail/{idOrder}")
	public String showDetail(ModelMap model, HttpSession httpSession, @PathVariable("idOrder") String idOrder) {
		Session session = factory.getCurrentSession();
		String hql = "FROM OrderDetail WHERE idOrder = " + idOrder;
		Query query = session.createQuery(hql);
		if (query.list().size() == 0)
			return "404";
		List<OrderDetail> list = query.list();
		model.addAttribute("orderDetail", list);
		float tong = 0;
		for (int i = 0; i < list.size(); i++) {

			tong += list.get(i).getNumber() * list.get(i).getPrice();
		}
		model.addAttribute("Tong", getTongGiaVN(tong));
		hql = "FROM TheOrder Where idOrder=" + idOrder;
		query = session.createQuery(hql);
		model.addAttribute("status", ((TheOrder) query.list().get(0)).getStatusOrder().trim());
		return "admin/ShowDetail";
	}
}
