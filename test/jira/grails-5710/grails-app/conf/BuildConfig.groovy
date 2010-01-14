grails.project.work.dir = "target"
grails.project.plugins.dir = "plugins"

grails.project.test.reports.dir	= "target/test-reports"

grails.project.dependency.resolution = {
    pom true
    // inherit Grails' default dependencies
    inherits( "global" ) {
        // uncomment to disable ehcache
        // excludes 'ehcache'
    }
    log "warn" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    repositories {        
        grailsPlugins()
        grailsHome()

        // uncomment the below to enable remote dependency resolution
        // from public Maven repositories
        mavenLocal()
        mavenCentral()
        //mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
    }
    /**
     * the dependencies are being processed even when in Maven mode (pom true)
     * and mask the fact that the maven exclusions are not being applied
     *
     * You need to comment them out which will then show the exclusions not
     * being processed. Most grails commands will then fail due to the
     */
//    dependencies {
//        compile('net.sourceforge.htmlunit:htmlunit:2.6') {
//            excludes 'xalan'
//            excludes 'xml-apis'
//        }
//    }
}
