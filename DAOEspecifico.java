package daos;

import entidades.Alimento;
import java.util.ArrayList;
import java.util.List;

public class DAOEspecifico extends DAOGenerico<Alimento> {

    public DAOEspecifico() {
        super(Alimento.class);
    }

    public int autoIdAlimento() {
        Integer a = (Integer) em.createQuery("SELECT MAX(e.idAlimento) FROM Alimento e ").getSingleResult();
        if (a != null) {
            return a + 1;
        } else {
            return 1;
        }
    }

    public List<Alimento> listByNome(String nome) {
        return em.createQuery("SELECT e FROM Alimento e WHERE e.nomeAlimento LIKE :nome").setParameter("nome", "%" + nome + "%").getResultList();
    }

    public List<Alimento> listById(int id) {
        return em.createQuery("SELECT e FROM Alimento e WHERE e.idAlimento = :id").setParameter("id", id).getResultList();
    }

    public List<Alimento> listInOrderNome() {
        return em.createQuery("SELECT e FROM Alimento e ORDER BY e.nomeAlimento").getResultList();
    }

    public List<Alimento> listInOrderId() {
        return em.createQuery("SELECT e FROM Alimento e ORDER BY e.idAlimento").getResultList();
    }

    public List<String> listInOrderNomeStrings(String qualOrdem) {
        List<Alimento> lf;
        if (qualOrdem.equals("id")) {
            lf = listInOrderId();
        } else {
            lf = listInOrderNome();
        }

        List<String> ls = new ArrayList<>();
        for (int i = 0; i < lf.size(); i++) {
            ls.add(lf.get(i).getIdAlimento() + "-" + lf.get(i).getNomeAlimento());
        }
        return ls;
    }
}
