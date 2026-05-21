package org.app.config;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import org.springframework.jdbc.datasource.DriverManagerDataSource;
import javax.persistence.EntityManagerFactory;

import org.springframework.orm.jpa.JpaTransactionManager;

import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;

import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;

import org.springframework.transaction.PlatformTransactionManager;

import org.springframework.transaction.annotation.EnableTransactionManagement;

import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import org.springframework.web.servlet.view.InternalResourceViewResolver;

import javax.sql.DataSource;

import java.util.Properties;

@Configuration
@EnableWebMvc

@ComponentScan(basePackages = "org.app")

@EnableTransactionManagement

@EnableJpaRepositories(
        basePackages =
                "org.app.Repositories"
)

public class MyConfig {

    @Bean
    public InternalResourceViewResolver
    viewResolver(){

        InternalResourceViewResolver vr =
                new InternalResourceViewResolver();

        vr.setPrefix("/WEB-INF/Views/");
        vr.setSuffix(".jsp");

        return vr;
    }

    @Bean
    public DataSource dataSource(){

        DriverManagerDataSource ds =
                new DriverManagerDataSource();

        ds.setDriverClassName(
                "org.postgresql.Driver");

        ds.setUrl(
                "jdbc:postgresql://localhost:5432/hospitalsystem");

        ds.setUsername("postgres");

        ds.setPassword("123456789");

        return ds;
    }

    @Bean
    public LocalContainerEntityManagerFactoryBean
    entityManagerFactory(){

        LocalContainerEntityManagerFactoryBean emf =
                new LocalContainerEntityManagerFactoryBean();

        emf.setDataSource(dataSource());

        emf.setPackagesToScan(
                "org.app.models"
        );

        emf.setJpaVendorAdapter(
                new HibernateJpaVendorAdapter()
        );

        Properties props = new Properties();

        props.put(
                "hibernate.hbm2ddl.auto",
                "update"
        );

        props.put(
                "hibernate.show_sql",
                "true"
        );

        props.put(
                "hibernate.format_sql",
                "true"
        );

        props.put(
                "hibernate.dialect",
                "org.hibernate.dialect.PostgreSQLDialect"
        );

        emf.setJpaProperties(props);

        return emf;
    }

    @Bean
    public PlatformTransactionManager
    transactionManager(
            EntityManagerFactory emf){

        return new JpaTransactionManager(emf);
    }
}